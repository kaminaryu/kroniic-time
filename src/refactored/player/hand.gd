extends Node2D

func _process(delta: float) -> void :
    const RADIUS = 48
    
    var player := get_parent()
    var mouse_pos := get_global_mouse_position()
    #hand_node.rotation = position.angle_to_point(mouse_pos)
    
    var rot_pointing_mouse := atan2(mouse_pos.y - player.global_position.y, mouse_pos.x - player.global_position.x)

    rotation = rot_pointing_mouse
    position = Vector2(RADIUS, 0).rotated(rot_pointing_mouse)
