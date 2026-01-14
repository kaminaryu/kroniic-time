extends Control


func _on_tree_entered() -> void:
    visible = false

func _input(event: InputEvent) -> void :
    if (event is InputEventKey) :
        if (event.pressed and (event.keycode == KEY_ESCAPE or event.keycode == KEY_ENTER) ) :
            if ($AnimationPlayer.is_playing()) :
                return_to_main()


func run() -> void :
    $AnimationPlayer.play("fade_in")
    visible = true


func return_to_main() -> void :
    Kronii.reset()
    visible = false
    get_tree().paused = false
    SceneManager.change_to_scene("MainMenu")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name == "fade_in") :
        return_to_main()
