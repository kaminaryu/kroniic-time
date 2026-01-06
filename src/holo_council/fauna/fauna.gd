extends Node2D

func _on_tree_entered() -> void:
    $SkillsHandler.entered_tree()

func _on_tree_exiting() -> void:
    $SkillsHandler.exited_tree()
