extends Node

var scenes: Dictionary[String, Dictionary] = {
    "Gameplay": {
        "node": preload("res://src/scenes/main.tscn"),
        "function": run_gameplay
    },
    "MainMenu": {
        "node": preload("res://src/scenes/main_menu.tscn"),
        "function": run_menu
    }
}

var current_scene: Node


func _ready() -> void :
    current_scene = get_tree().current_scene
    

var pause_menu_scn = preload("res://src/UI/pause_menu.tscn")
var pausing = false
var on_main_menu = true


func _input(event: InputEvent) -> void:
    if (event.is_action_pressed("pause")) :
        if (pausing) :
            return
        
        if (on_main_menu) :
            return
            
        pausing = true
        #change_to_scene("MainMenu")
        var pause = pause_menu_scn.instantiate()
        get_tree().root.get_node("Main/UI").add_child(pause)
        
        
    
    

func change_to_scene(scene_name: String) -> void :
    var scene: Node = scenes[scene_name]["node"].instantiate()
    var scene_func = scenes[scene_name]["function"]
    
    if (scene_name == "MainMenu") :
        on_main_menu = true
    else :
        on_main_menu = false
        
    
    if (current_scene) :
        current_scene.queue_free()
    
    current_scene = scene
    get_tree().root.add_child(scene)
    
    # Wait one frame to ensure _ready() has finished everywhere
    await get_tree().process_frame
    scene_func.call()
    
    await get_tree().process_frame

    
    
func run_gameplay() -> void :
    Kronii.reset()
    PlayerAttributes.reset()
    SkillsStatisticHandler.reset()
    SquadHandler.reset()
    
    
func run_menu() -> void :
    pass
