extends Node2D

var blackhole_scene := preload("res://src/skills/sana/black_hole.tscn")

func _input(event: InputEvent) -> void :
    if (event is not InputEventKey) :
        return
        
    if (Input.is_action_just_pressed("ultimate")) :
        summon_blackhole()
        
        
func summon_blackhole() -> void :
    var blackhole = blackhole_scene.instantiate()
    blackhole.global_position = get_global_mouse_position()
    
    get_tree().root.add_child(blackhole)
