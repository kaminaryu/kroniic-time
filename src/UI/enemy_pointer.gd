extends Node2D

var target: Node

func _process(delta: float) -> void :
    var player: Node = get_tree().root.get_node("Main/Player")
    
    if (not is_instance_valid(target)) :
        return
        
    look_at(target.global_position)
    global_position = player.global_position + Vector2.RIGHT.rotated(rotation) * 67
