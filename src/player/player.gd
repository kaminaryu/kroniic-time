extends CharacterBody2D

@export var speed := 200
@export var item: String
var knockback_lerp := 0.1

var knockback: int = 64
var damage: int = 1


var speed_modifier: float = 1.0
var damage_modifier: float = 1.0


var is_hit := false
var knockback_pos: Vector2
var iframe := false


func read_file(path: String) -> String:
    # Component: Safety Check
    if not FileAccess.file_exists(path):
        print("Error: File does not exist at ", path)
        return ""

    # Component: Opening the File
    # FileAccess.open takes (path, mode)
    var file = FileAccess.open(path, FileAccess.READ)

    if file == null:
        print("Error: Could not open file. Error code: ", FileAccess.get_open_error())
        return ""

    # Component: Content Extraction
    var content = file.get_as_text()

    # Note: No need to call file.close() in Godot 4; 
    # it closes automatically when the variable goes out of scope.
    return content
    
    
func _input(event: InputEvent) -> void:
    if (event is InputEventMouseButton) :
        if (event.pressed and event.button_index == MOUSE_BUTTON_MIDDLE) :
            print(read_file("res://src/data/hi.json"))


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
        
        
    get_item()



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
        
    velocity = move_dir * speed * speed_modifier
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


func get_item() -> void :
    var items = JSON.parse_string(read_file("res://src/data/items.json"))

    for i in items :
        if (item == i) :
            if (items[i]["Attribute"] == "Speed") :
                speed_modifier = items[i]["Modifier"]
            else :
                speed_modifier = 1.0
                
            if (items[i]["Attribute"] == "Damage") :
                damage_modifier = items[i]["Modifier"]
            else :
                damage_modifier = 1.0
    

#region DAMAGE
func take_damage(hostile_entity: Node, knockback_strength: int, damage: int) -> void :
    # iframes
    if (is_hit) :
        return
        
    # knockback
    is_hit = true
    iframe = true
    
    var opposite_direction := atan2(position.y - hostile_entity.position.y, position.x - hostile_entity.position.x)
    knockback_pos = position + Vector2.RIGHT.rotated(opposite_direction) * knockback_strength
    
    # decrease the time
    Kronii.time_left -= damage
    
    $MemberController/AnimationPlayer.play("flashes")
    
    
func knocking_back() :
    position = position.lerp(knockback_pos, knockback_lerp)
    
    if (position.distance_to(knockback_pos) < 4) :
        is_hit = false
    
#endregion


#region SIGNAL
func _on_hitbox_body_entered(body: Node2D) -> void:
    if (body.is_in_group("Slimes")) :
        take_damage(body, 64, 10)        


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name == "flashes") :
        iframe = false
    
#endregion
