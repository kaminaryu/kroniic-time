extends Node2D


func _on_holo_council_pressed() -> void:
    SceneManager.change_to_scene("HoloCouncilTutorial")


func _on_enemies_pressed() -> void:
    SceneManager.change_to_scene("EnemiesTutorial")


func _on_go_back_pressed() -> void:
    SceneManager.change_to_scene("Tutorial")
