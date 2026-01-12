extends CharacterBody2D

const DASH_LERP := 0.15
const CHARGING_TIME := 2.0
const COOLDOWN := 5.0 
const MAX_DETECT_RANGE := 384
const MAX_RETENTION_RANGE := 512

var target_pos: Vector2
var target_found: bool = false
var is_dashing: bool = false
var cooling_down: bool = false
var player: Node
var knockback_pos: Vector2
var is_hit: bool = false
var is_kb: bool = false

@export var health: float = 3.0


func _ready() -> void :
    add_to_group("Darts")
    add_to_group("Enemies")
    
    randomize()
    player = get_tree().root.get_node("Main/Player")
    

func _process(delta: float) -> void :
    if ($EnemiesSharedAttributes.frozen) :
        return
        
    if ($EnemiesSharedAttributes.in_blackhole) :
        return
        
    if (is_kb) :
        knocking_back()
        
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
                $Charging.stop()
                
        
    else :
        target_pos = player.global_position
        find_target()
        
    
func find_target() -> void :
    if (global_position.distance_to(target_pos) < MAX_DETECT_RANGE) :
        target_found = true
        $Charging.wait_time = randf_range(CHARGING_TIME, CHARGING_TIME + 2.0)  # ts is the offset
        $Charging.start()
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
    $Charging.stop()
    $Cooldown.stop()
    $Cooldown.wait_time = randf_range(COOLDOWN, COOLDOWN + 2) # ts is the offset
    $Cooldown.start()
        
func take_damage(_source: Node, _knockback: int, damage: float) -> void :
    health -= damage;
    
    if (is_hit) :
        return
        
    is_hit = true
    
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
      
    

func knock_back(hitter_node: Node, knockback: int) -> void :  
    var opposite_direction := atan2(global_position.y - hitter_node.global_position.y, global_position.x - hitter_node.global_position.x)
    var variable_knockback := knockback + randf_range(-8, 8)
    knockback_pos = position + variable_knockback * Vector2.RIGHT.rotated(opposite_direction)
    
    is_kb = true
    
    $Charging.start()
    if (is_dashing) :
        stop_dashing()
    
    
# knock back animation
func knocking_back() -> void :
    position = position.lerp(knockback_pos, 0.1)
    
    if (position.distance_to(knockback_pos) < 8) :
        is_kb = false
    
    
          

#region SIGNALS
func _on_charging_timeout() -> void:
    is_dashing = true
    
func _on_cooldown_timeout() -> void :
    cooling_down = false


func _on_damaging_hitbox_body_entered(body: Node2D) -> void:
    if (body.name == "Player") :
        stop_dashing()
        body.take_damage(self, 128, 20)
        #get_tree().quit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name == "death") :
        queue_free()
    elif (anim_name == "flashes") :
        is_hit = false


#endregion
