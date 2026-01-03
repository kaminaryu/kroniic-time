extends CharacterBody2D

@onready var JUMP_RANGE_MIN: int = $AttackRange/CollisionShape2D.shape.radius / 4
@onready var JUMP_RANGE_MAX: int = $AttackRange/CollisionShape2D.shape.radius / 2
const JUMP_DELAY: float = 0.5

#var player_in_range: boolean = false
#var player_location: 
var player_node: Node = null
var is_jumping: bool = false
var target_position: Vector2
var start_end_mid_point: Vector2 
var start_distance_to_mid_point: int # dont ask


func _ready() -> void :
    #position = Vector2(600, 300)
    randomize() # shuffle the seeds
    
    $Timer.wait_time = randf_range(JUMP_DELAY, JUMP_DELAY + .5)
    $Timer.start()
    
    
func _process(delta: float) -> void :
    if (is_jumping) :
        jump()
        
    $Target.visible = is_jumping
    $Target.global_position = target_position
    
    
func vector2_lerp(start: Vector2, end: Vector2, weight: float) -> Vector2 :
    return start + (end - start) * weight
    
    
func start_jump() -> void :
    var target_direction: Vector2
    var target_distance: int
    var position_offset: Vector2
    
    # check if a player is in range
    if (player_node) :
        var player_angle := atan2(player_node.global_position.y - global_position.y, player_node.global_position.x - global_position.x)        
        target_direction = Vector2.RIGHT.rotated(player_angle)
        
        print("ehsufhuosnoi")

        
    else :
        # get a random vector in a range
        target_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
  
    target_distance = randf_range(JUMP_RANGE_MIN, JUMP_RANGE_MAX)

    position_offset = target_direction * target_distance
    
    target_position = global_position + position_offset
        
    is_jumping = true
    start_end_mid_point = Vector2( (position.x + target_position.x) / 2, (position.y + target_position.y) / 2 )
    start_distance_to_mid_point = global_position.distance_to(start_end_mid_point)
    
    print(position, global_position)
    
    
func stop_jump() -> void :
    is_jumping = false
    $Timer.wait_time = randf_range(JUMP_DELAY, JUMP_DELAY + 1.5)
    $Timer.start()
    
    
func jump() -> void :
    global_position = vector2_lerp(global_position, target_position, 0.05)
    
    ## height
    #var s = 1 - (start_distance_to_mid_point / position.distance_to(start_end_mid_point)) * 0.01
    #scale = Vector2(s, s)

    var current_dist = global_position.distance_to(start_end_mid_point)

    # This maps distance from [Full Distance -> 0] to scale [1.0 -> 1.5]
    var size_scalar = remap(current_dist, start_distance_to_mid_point, 0.0, 1.0, 1.25)

    scale = Vector2(size_scalar, size_scalar)
    
    if global_position.distance_to(target_position) < 8 :
        stop_jump()
        
        
        
func _on_timer_timeout() -> void:
    start_jump()
    pass # Replace with function body.


func _on_attack_range_body_entered(body: Node2D) -> void:
    if (body.name == "Player") :
        #player_in_range = true
        player_node = body


func _on_attack_range_body_exited(body: Node2D) -> void:
    if (body.name == "Player") :
        #player_in_range = true
        player_node = null
