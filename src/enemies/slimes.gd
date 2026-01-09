extends CharacterBody2D

@onready var JUMP_RANGE_MIN: int = $AttackRange/CollisionShape2D.shape.radius / 4
@onready var JUMP_RANGE_MAX: int = $AttackRange/CollisionShape2D.shape.radius / 2

@export var on_air: bool = false
@export var health: int = 3
const KNOCKBACK_STRENGTH: float = 64
const JUMP_DELAY: float = 0.5
const JUMP_LERP := 0.04
var knockback_lerp := 0.1

var is_hit := false
var knockback_pos: Vector2

var player_node: Node = null
var is_jumping: bool = false
var target_position: Vector2
var start_end_mid_point: Vector2 
var start_distance_to_mid_point: int # dont ask


func _ready() -> void :
    #position = Vector2(600, 300)
    randomize() # shuffle the seeds
    
    add_to_group("Slimes")
    
    $Timer.wait_time = randf_range(JUMP_DELAY, JUMP_DELAY + .5)
    $Timer.start()
    
    
func _process(delta: float) -> void :
    if (is_jumping) :
        jump()
        
    $Target.visible = is_jumping
    $Target.global_position = target_position
    
    if (is_hit) :
        knocking_back()
    
    

#region JUMPING MECHANICS
# get the jump angle and jump length
func start_jump() -> void :
    var target_direction: Vector2
    var target_distance: int
    
    # randomized jump distance
    
    # check if a player is in range
    if (player_node) :
        var player_angle := atan2(player_node.global_position.y - global_position.y, player_node.global_position.x - global_position.x)        
        target_direction = Vector2.RIGHT.rotated(player_angle)
        # if the player is closer than target distance, use the player as the target but a little offset from the mid
        target_distance = min(global_position.distance_to(player_node.position) * 0.9, JUMP_RANGE_MAX)

    else :
        # get a random vector direction in a range
        target_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
        target_distance = randf_range(JUMP_RANGE_MIN, JUMP_RANGE_MAX)   

    # scale the target pos
    target_position = global_position + target_direction * target_distance
        
    # to disable the hitbox whilst on air
    $Hitbox.disabled = true
    
    is_jumping = true
    on_air = true
    
    # for calculating the jump "height"
    start_end_mid_point = Vector2( (position.x + target_position.x) / 2, (position.y + target_position.y) / 2 )
    start_distance_to_mid_point = global_position.distance_to(start_end_mid_point)
    
    
func stop_jump() -> void :
    is_jumping = false
    on_air = false
    
    scale = Vector2.ONE
    
    $Hitbox.disabled = false
        
    $Timer.wait_time = randf_range(JUMP_DELAY, JUMP_DELAY + 1.5)
    $Timer.start()
    
    
func jump() -> void :
    global_position = global_position.lerp(target_position, JUMP_LERP)
    
    ## calculate the "height"
    var current_dist = global_position.distance_to(start_end_mid_point)

    # This maps distance from [Full Distance -> 0] to scale [1.0 -> 1.5]
    var size_scalar = remap(current_dist, start_distance_to_mid_point, 0.0, 1.0, 1.25)

    scale = Vector2(size_scalar, size_scalar)
    
    if global_position.distance_to(target_position) < 8 :
        #global_position = target_position
        stop_jump()
#endregion
     
#region ON GETTING HIT
func take_damage(hitter_node: Node, knockback: int, damage: float) -> void :
    # iframes
    if (is_hit) :
        return
        
    #get_tree().quit()
        
    $Timer.stop()
    scale = Vector2.ONE
    
        
    is_hit = true
    health -= damage
    
    if (health < 1) :
        $AnimationPlayer.play("death")
        Kronii.time_left += 5
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

#region SIGNALS  
func _on_timer_timeout() -> void:
    start_jump()


func _on_attack_range_body_entered(body: Node2D) -> void:
    if (body.name == "Player") :
        #player_in_range = true
        player_node = body


func _on_attack_range_body_exited(body: Node2D) -> void:
    if (body.name == "Player") :
        #player_in_range = true
        player_node = null

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name == "death") :
        queue_free()
    if (anim_name == "flashes") :
        is_hit = false
        $Timer.wait_time = 0.5
        $Timer.start() # resets the timer
            
#endregion
