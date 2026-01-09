extends CharacterBody2D

@export var speed = 100
@export var health:float = 10.0

var knockback_lerp := 0.1

var is_hit := false
var knockback_pos: Vector2

var player: Node

func _ready() -> void :
    player = get_tree().root.get_node("Main/Player")
    add_to_group("Giants")
    #player = Node2D.new()
    #add_child(player)
    
    
func _process(delta: float) -> void :
    var direction := atan2(player.global_position.y - global_position.y, player.global_position.x - global_position.x) 
    $GiantSword.global_position = global_position + Vector2.RIGHT.rotated(direction) * 64
    $GiantSword.look_at(player.global_position)
    
    

    
func _physics_process(delta: float) -> void :
    if (is_hit) :
        knocking_back()
        return
        
    var distance_to_player = global_position.distance_to(player.global_position)
    # if in attack range
    if (distance_to_player < 128) :
        $GiantSword.start_attacking()
        
    elif (distance_to_player < 256) :
        var direction := atan2(player.global_position.y - global_position.y, player.global_position.x - global_position.x) 
        
        $GiantSword.stop_attacking()
        
        velocity = Vector2.RIGHT.rotated(direction) * speed
        
        move_and_slide()



#region ON GETTING HIT
func take_damage(hitter_node: Node, knockback: int, damage: float) -> void :
    # iframes
    if (is_hit) :
        return
        
    $Timer.stop()
        
    is_hit = true
    health -= damage
    
    if (health < 1) :
        $AnimationPlayer.play("death")
        Kronii.time_left += 10
        return
        
    var opposite_direction := atan2(global_position.y - hitter_node.global_position.y, global_position.x - hitter_node.global_position.x)
    var variable_knockback := knockback + randf_range(-8, 8)
    knockback_pos = position + variable_knockback * Vector2.RIGHT.rotated(opposite_direction)
    
    $AnimationPlayer.play("flashes")

    
# knock back animation
func knocking_back() -> void :
    position = position.lerp(knockback_pos, knockback_lerp)
    
    #if (position.distance_to(knockback_pos) < 4) :
        #is_hit = false
#endregion   





func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name == "death") :
        queue_free()
    if (anim_name == "flashes") :
        is_hit = false
