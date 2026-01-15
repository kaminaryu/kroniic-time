extends Node2D



func _on_play_pressed() -> void:
    SceneManager.change_to_scene("Gameplay")

func _on_quit_pressed() -> void:
    get_tree().quit()


func _on_tutorial_pressed() -> void:
    SceneManager.change_to_scene("Tutorial")


func _on_options_pressed() -> void:
    SceneManager.change_to_scene("Credits")
