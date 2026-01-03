extends Node2D

func _process(delta: float) -> void :
    const RADIUS = 64 + 16
    
    var hand_node := $Hand
    var mouse_pos := get_global_mouse_position()
    #hand_node.rotation = position.angle_to_point(mouse_pos)
    
    var rot_pointing_mouse := atan2(mouse_pos.y - position.y, mouse_pos.x - position.x)

    hand_node.rotation = rot_pointing_mouse
    hand_node.position = Vector2(RADIUS, 0).rotated(rot_pointing_mouse)
