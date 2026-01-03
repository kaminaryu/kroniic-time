extends CharacterBody2D

@export var speed = 200

var slime_scene = preload("res://src/enemies/slimes.tscn")

func _process(delta: float) -> void :
    const RADIUS = 64 + 16
    
    var hand_node := $Hand
    var mouse_pos := get_global_mouse_position()
    #hand_node.rotation = position.angle_to_point(mouse_pos)
    
    var rot_pointing_mouse := atan2(mouse_pos.y - position.y, mouse_pos.x - position.x)

    hand_node.rotation = rot_pointing_mouse
    hand_node.position = Vector2(RADIUS, 0).rotated(rot_pointing_mouse)



func _physics_process(delta: float) -> void:
    var move_dir = Vector2.ZERO
    
    if Input.is_action_pressed("move_up") :
         move_dir.y += -1
    if Input.is_action_pressed("move_down") :
         move_dir.y += 1
    if Input.is_action_pressed("move_left") :
         move_dir.x += -1
    if Input.is_action_pressed("move_right") :
         move_dir.x += 1
        
    if move_dir.length() > 0 :
        move_dir = move_dir.normalized()
        
    velocity = move_dir * speed
    move_and_slide()
    
    # emitting particle when squad member changes    
    if Input.is_action_just_pressed("change_squad_1") :
        $SpawnEffect.color = Color("c42430")
        $SpawnEffect.emitting = true
    elif Input.is_action_just_pressed("change_squad_2") :
        $SpawnEffect.color = Color("33984b")
        $SpawnEffect.emitting = true
    elif Input.is_action_just_pressed("change_squad_3") :
        $SpawnEffect.color = Color("8a4836")
        $SpawnEffect.emitting = true
    elif Input.is_action_just_pressed("change_squad_4") :
        $SpawnEffect.color = Color("f6ca9f")
        $SpawnEffect.emitting = true


func _input(event: InputEvent) -> void :
    if (event is InputEventMouseButton) :
        if (event.pressed and event.button_index == MOUSE_BUTTON_MIDDLE) :
            var slime = slime_scene.instantiate()
            slime.position = Vector2(676, 67)
            get_tree().root.add_child(slime)
