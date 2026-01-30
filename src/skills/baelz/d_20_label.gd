extends Label


func _process(delta: float) -> void :
    global_position = get_tree().root.get_node("NewPlayer").global_position

func _on_timer_timeout() -> void:
    queue_free()
