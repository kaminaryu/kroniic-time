extends CharacterBody2D

var is_idle: bool = true

func _physics_process(delta: float) -> void:
    var move_dir = Vector2.ZERO
    
    is_idle = true
    if Input.is_action_pressed("move_up") :
        move_dir.y += -1
        is_idle = false
    if Input.is_action_pressed("move_down") :
        move_dir.y += 1
        is_idle = false
    if Input.is_action_pressed("move_left") :
        move_dir.x += -1
        is_idle = false
    if Input.is_action_pressed("move_right") :
        move_dir.x += 1
        is_idle = false
        
    if move_dir.length() > 0 :
        move_dir = move_dir.normalized()
        
    var speed = $Attributes.get_speed()
    velocity = move_dir * speed * delta
    move_and_slide()


func get_idle_status() -> bool :
    return is_idle
