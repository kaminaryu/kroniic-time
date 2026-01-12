extends Node2D

var turret_scene := preload("res://src/skills/fauna/sapling.tscn")

func run() -> void :
    spawn()        

func spawn() -> void :
    var player := get_parent()
    var peashooter := turret_scene.instantiate()
    
    #peashooter.global_position = player.global_position
    peashooter.global_position = get_global_mouse_position()
    get_tree().root.add_child(peashooter)
    
