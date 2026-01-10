extends Node2D

var tree_scene := preload("res://src/skills/fauna/tree_of_life.tscn")

func _input(event: InputEvent) -> void :
    if (event is not InputEventKey) :
        return
        
    if (Input.is_action_just_pressed("ultimate")) :
        spawn_tree_life()
        
        
func spawn_tree_life() -> void :
    var tree = tree_scene.instantiate()
    
    tree.global_position = get_parent().global_position + Vector2.UP * 64
    get_tree().root.add_child(tree)
