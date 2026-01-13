extends Node2D



func _on_play_pressed() -> void:
    SceneManager.change_to_scene("Gameplay")


func _on_quit_pressed() -> void:
    get_tree().quit()
