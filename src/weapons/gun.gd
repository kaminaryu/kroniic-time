extends Node2D

@export var spread: float = 0.0
var bullet_scene := preload("res://src/weapons/bullet.tscn")

func _input(event: InputEvent) -> void :
    if event is not InputEventMouseButton :
        return
        
    if event.pressed and event.button_index == MOUSE_BUTTON_LEFT :
        var mouse_pos := get_global_mouse_position()
        var aim_rotation := atan2(mouse_pos.y - global_position.y, mouse_pos.x - global_position.x)
        var bullet := bullet_scene.instantiate()
        
        bullet.direction = Vector2.RIGHT.rotated(aim_rotation)
        bullet.position = global_position
        bullet.source_of_fire = self.get_parent().get_parent() # player
        
        if (SquadHandler.selected_member == "Baelz") :
            bullet.get_node("Sprite2D").modulate = Color8(255, 0, 0)
            
        elif (SquadHandler.selected_member == "Sana") :
            bullet.get_node("Sprite2D").modulate = Color8(246, 202, 159)
        
        get_tree().root.add_child(bullet)
