extends Node

var scenes: Dictionary[String, Dictionary] = {
    "Gameplay": {
        "node": preload("res://src/scenes/main.tscn"),
        "function": run_gameplay
    },
    "MainMenu": {
        "node": preload("res://src/scenes/main_menu.tscn"),
        "function": run_menu
    },
    "Tutorial": {
        "node": preload("res://src/scenes/TutorialPage.tscn"),
        'function': run_tuto
    },
    "CharactersTutorial": {
        "node": preload("res://src/scenes/character_tutorial.tscn"),
        "function": run_char_tuto  
    },
    "Lore": {
        "node": preload("res://src/scenes/lore_tutorial.tscn"),
        "function": run_lore_tuto  
    },
    "ControlTutorial": {
        "node": preload("res://src/scenes/control_tutorial.tscn"),
        "function": run_ctrl_tuto  
    },
    "HoloCouncilTutorial": {
        "node": preload("res://src/scenes/holo_tutorial.tscn"),
        "function": run_holo_tuto  
    },
    "EnemiesTutorial": {
        "node": preload("res://src/scenes/enemies_tutorial.tscn"),
        "function": run_enem_tuto  
    },
    "Credits": {
        "node": preload("res://src/scenes/credits.tscn"),
        "function": run_enem_tuto  
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
        #if (pausing) :
            #return
        
        if (current_scene.name != "Main") :
            return
            
        pausing = !pausing
        #change_to_scene("MainMenu")
        var pause = pause_menu_scn.instantiate()
        get_tree().root.get_node("Main/UI").add_child(pause)
        
        get_tree().paused = pausing
        
        
func game_over() -> void :
    var game_over_ui: = get_tree().root.get_node("Main/UI/GameOver")
    
    get_tree().paused = true
    game_over_ui.run()
    

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
    
func run_tuto() -> void:
    pass

func run_char_tuto() -> void:
    pass
    
func run_lore_tuto() -> void:
    pass
    
func run_ctrl_tuto() -> void:
    pass

func run_holo_tuto() -> void:
    pass
    
func run_enem_tuto() -> void:
    pass
