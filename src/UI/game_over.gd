extends Control


func _on_tree_entered() -> void:
    visible = false

func _input(event: InputEvent) -> void :
    if (event is InputEventKey) :
        if (event.pressed and (event.keycode == KEY_ESCAPE or event.keycode == KEY_ENTER) ) :
            $Timer.stop()
            return_to_main()


func run() -> void :
    $Timer.start()
    $AnimationPlayer.play("fade_in")
    visible = true


func _on_timer_timeout() -> void:
    return_to_main()
    
func return_to_main() -> void :
    Kronii.reset()
    visible = false
    get_tree().paused = false
    SceneManager.change_to_scene("MainMenu")
