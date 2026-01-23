extends Node2D

var bullet_scene: PackedScene = preload("res://src/refactored/temp/bullet.tscn")
    
func _input(event: InputEvent) -> void :
    if (event is InputEventMouseButton) :
        if (event.pressed and event.button_index == MOUSE_BUTTON_RIGHT) :
            global_position = get_global_mouse_position()



func _on_shoot_timeout() -> void:
    var bullet = bullet_scene.instantiate()
    bullet.global_position = global_position
    bullet.set_damage(1);
    bullet.look_at(get_global_mouse_position())
    
    get_tree().root.add_child(bullet)
