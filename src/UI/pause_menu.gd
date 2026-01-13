extends Control


func _on_button_pressed() -> void:
    get_tree().paused = false

    SceneManager.pausing = false
    get_tree().root.get_node("Main/UI/PauseMenu").queue_free()


func _on_button_3_pressed() -> void:
    get_tree().paused = false

    SceneManager.pausing = false
    SceneManager.change_to_scene("MainMenu")
