extends CharacterBody2D

@export var speed = 200

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
