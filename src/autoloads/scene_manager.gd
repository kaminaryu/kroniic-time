extends Node

var scenes: Dictionary[String, Dictionary] = {
    "Gameplay": {
        "node": preload("res://src/main.tscn"),
        "function": run_gameplay
    },
    "MainMenu": {
        "node": preload("res://src/main_menu.tscn"),
        "function": run_menu
    }
}

var current_scene: Node


func _ready() -> void :
    change_to_scene("Gameplay")

func change_to_scene(scene_name: String) -> void :
    var scene: PackedScene = scenes[scene_name]["node"]
    var scene_func = scenes[scene_name]["function"]
    
    scene_func.call()
    
    
    
    
func run_gameplay() -> void :
    pass
    
func run_menu() -> void :
    pass
