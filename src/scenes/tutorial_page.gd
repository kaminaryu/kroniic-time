extends Node2D

func _on_go_back_pressed() -> void:
    SceneManager.change_to_scene("MainMenu")


func _on_first_tuto_pressed() -> void:
    SceneManager.change_to_scene("ControlTutorial")


func _on_second_tuto_pressed() -> void:
    SceneManager.change_to_scene("CharactersTutorial")


func _on_third_tuto_pressed() -> void:
    SceneManager.change_to_scene("Lore")
