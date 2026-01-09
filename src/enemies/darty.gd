extends CharacterBody2D

const DASH_LERP := 0.15
const CHARGING_TIME := 2.0
const COOLDOWN := 5.0 
const MAX_DETECT_RANGE := 512
const MAX_RETENTION_RANGE := 768

var target_pos: Vector2
var target_found: bool = false
var is_dashing: bool = false
var cooling_down: bool = false
var player: Node

@export var health: float = 3.0


func _ready() -> void :
    add_to_group("Darts")
    randomize()
    
    player = get_tree().root.get_node("Main/Player")
    

func _process(delta: float) -> void :
    #print("CD, TF, DSH: ", cooling_down, " | ", target_found, " | ", is_dashing)
    if (cooling_down) :
        $Sprite2D.modulate = Color8(67, 67, 67)
        return
    
    $Sprite2D.modulate = Color8(255, 255, 255)


    if (target_found) :
        if (is_dashing) :
            dash()
        else :
            target_pos = player.global_position
            look_at(target_pos)
            # if player is too far away
            if (!is_in_retention_range()) :
                target_found = false
                $Timer.stop()
                
        
    else :
        target_pos = player.global_position
        find_target()
        
    
func find_target() -> void :
    if (global_position.distance_to(target_pos) < MAX_DETECT_RANGE) :
        target_found = true
        $Timer.wait_time = randf_range(CHARGING_TIME, CHARGING_TIME + 2.0)  # ts is the offset
        $Timer.start()
    else :
        rotation += -PI/32
    

func is_in_retention_range() -> bool :
    if (global_position.distance_to(target_pos) > MAX_RETENTION_RANGE) :
        return false
    return true


func dash() -> void :
    global_position = global_position.lerp(target_pos, DASH_LERP)
    #velocity = velocity.lerp(target_pos, DASH_LERP)
    
    #move_and_slide()
    
    if (global_position.distance_to(target_pos) < 2) :
        stop_dashing()

func stop_dashing() -> void :
    is_dashing = false
    target_found = false
    cooling_down = true
    $Timer.wait_time = randf_range(COOLDOWN, COOLDOWN + 2) # ts is the offset
    $Timer.start()
        
func take_damage(_source: Node, _knockback: int, damage: float) -> void :
    health -= damage;
    
    
    if (health < 1) :
        $AnimationPlayer.play("death")
    else :
        #var anim: Animation = $AnimationPlayer.get_animation("flashes")
        #var track_idx = anim.find_track("Darty:rotation", Animation.TYPE_VALUE)
        #
        #if track_idx != -1:
            ## 3. Update the 2nd keyframe (index 1)
            ## Key 0 is at time 0.0, Key 1 is at time 1.0 (as seen in your image)
            #anim.track_set_key_value(track_idx, 1, deg_to_rad(rotation))
            
        $AnimationPlayer.play("flashes")
        
    
    if (is_dashing) :
        stop_dashing()
    
        

#region SIGNALS
func _on_timer_timeout() -> void:
    # when done cooling down after attacking
    if (cooling_down) :
        cooling_down = false
    # when done charging up
    else :
        is_dashing = true


func _on_damaging_hitbox_body_entered(body: Node2D) -> void:
    if (body.name == "Player") :
        stop_dashing()
        body.take_damage(self, 128, 20)
        #get_tree().quit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name == "death") :
        queue_free()


#endregion
