extends Control


func _on_button_pressed() -> void:
    SceneManager.pausing = false
    
    var pause_menu = get_tree().root.get_node("Main/UI/PauseMenu")
    if (pause_menu) :
        pause_menu.queue_free()

    get_tree().paused = false


func _on_button_3_pressed() -> void:
    get_tree().paused = false

    SceneManager.pausing = false
    SceneManager.change_to_scene("MainMenu")
