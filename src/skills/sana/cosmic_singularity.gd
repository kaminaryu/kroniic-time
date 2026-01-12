extends Node2D

var blackhole_scene := preload("res://src/skills/sana/black_hole.tscn")

func run() -> void :
    summon_blackhole()
        
func summon_blackhole() -> void :
    var blackhole = blackhole_scene.instantiate()
    blackhole.global_position = get_global_mouse_position()
    
    get_tree().root.add_child(blackhole)
