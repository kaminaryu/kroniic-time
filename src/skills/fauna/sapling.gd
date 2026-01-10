extends Area2D

var pea_scene := preload("res://src/skills/fauna/pea.tscn")

const COOLDOWN: float = 1.0

var targets: Array[Node]
var cooling_down := false
var damage_multiplier: float = 1.0 # for Tree of Life

func _ready() -> void :
    add_to_group("Saplings")

func _process(delta: float) -> void :
    if (targets.is_empty()) :
        return
    
    #var mouse_pos: Vector2 = get_global_mouse_position()
    if (not targets[0]) :
        return
        
    look_at_target( targets[0].global_position ) 
    
    if (not cooling_down) :
        cooling_down = true
        shoot()
    
    
func look_at_target(target_pos: Vector2) -> void :
    var look_angle: float = atan2(target_pos.y - global_position.y, target_pos.x - global_position.x)
    
    $Head.rotation = look_angle 
    
    # Check if the mouse is in Quadrant 2 or 3 (Left Side)
    if abs(look_angle) > PI / 2:
        $Head.scale.y = -1  # Mirrors the sprite vertically to fix orientation
    else:
        $Head.scale.y = 1   # Resets to normal orientation
        
        
func shoot() -> void :
    var angle: float = $Head.rotation
    var pea = pea_scene.instantiate()
    
    pea.direction = Vector2.RIGHT.rotated(angle)
    pea.global_position = global_position
    pea.shooter = self
    pea.damage_multiplier = damage_multiplier
    
    get_tree().root.add_child(pea)
    
    cooling_down = true
    $Timer.wait_time = COOLDOWN
    $Timer.start()
    
    
func _on_timer_timeout() -> void:
    cooling_down = false


func _on_lifetime_timeout() -> void:
    queue_free()


func _on_body_entered(body: Node2D) -> void:
    if (body.is_in_group("Enemies")) :
        targets.append(body)

func _on_body_exited(body: Node2D) -> void:
    if (body in targets) :
        targets.pop_at(0)
