extends Control

func play_transition(dungeon: Node, current_level: int) -> void :
    get_tree().paused = true
    
    $ColorRect/AnimationPlayer.play("trans_in")
    dungeon.actually_create_dungeon(current_level)
    


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name == "trans_in") :
        get_tree().paused = false
        get_tree().root.get_node("Main/EnemyPointerManager").generate_pointers()
        $ColorRect/AnimationPlayer.play("trans_out") 
        

        
