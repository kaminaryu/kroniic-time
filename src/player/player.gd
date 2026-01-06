extends CharacterBody2D

@export var speed := 200
const knockback_strength := 64
var knockback_lerp := 0.1

var is_hit := false
var knockback_pos: Vector2
var iframe := false


var slime_scene = preload("res://src/enemies/slimes.tscn")

func _process(delta: float) -> void :
    const RADIUS = 16 + 16
    
    var hand_node := $Hand
    var mouse_pos := get_global_mouse_position()
    #hand_node.rotation = position.angle_to_point(mouse_pos)
    
    var rot_pointing_mouse := atan2(mouse_pos.y - position.y, mouse_pos.x - position.x)

    hand_node.rotation = rot_pointing_mouse
    hand_node.position = Vector2(RADIUS, 0).rotated(rot_pointing_mouse)
    
    if (is_hit) :
        knocking_back()



func _physics_process(delta: float) -> void:
    # disable control when hit
    if (is_hit) :
        return
        
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

#region DEBUG
func _input(event: InputEvent) -> void :
    if (event is InputEventMouseButton) :
        if (event.pressed and event.button_index == MOUSE_BUTTON_MIDDLE) :
            var slime = slime_scene.instantiate()
            slime.position = Vector2(676, 67)
            get_tree().root.add_child(slime)
#endregion

#region DAMAGE
func damage_player(hostile_entity: Node) -> void :
    # iframes
    if (is_hit) :
        return
        
    # knockback
    is_hit = true
    iframe = true
    
    var opposite_direction := atan2(position.y - hostile_entity.position.y, position.x - hostile_entity.position.x)
    knockback_pos = position + Vector2.RIGHT.rotated(opposite_direction) * knockback_strength
    
    $MemberController/AnimationPlayer.play("flashes")
    
    
func knocking_back() :
    position = position.lerp(knockback_pos, knockback_lerp)
    
    if (position.distance_to(knockback_pos) < 4) :
        is_hit = false
    
#endregion


#region SIGNAL
func _on_hitbox_body_entered(body: Node2D) -> void:
    if (body.is_in_group("Slimes")) :
        damage_player(body)        


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name == "flashes") :
        iframe = false
    
#endregion
