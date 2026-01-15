extends Node2D

var tree_scene := preload("res://src/skills/fauna/tree_of_life.tscn")

func run() -> void :
    spawn_tree_life()
      
func spawn_tree_life() -> void :
    $AudioStreamPlayer2D.playing = true
    var tree = tree_scene.instantiate()
    
    tree.global_position = get_parent().global_position + Vector2.UP * 64
    get_tree().root.add_child(tree)
