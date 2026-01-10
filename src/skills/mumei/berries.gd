extends Node2D

func _input(event: InputEvent) -> void :
    if (event is not InputEventKey) :
        return
        
    if (event.is_action_pressed("skill1")) :
        print("eatring berrues")
        PlayerAttributes.speed_multiplier = 1.5
        PlayerAttributes.damage_multiplier = 1.5
        
        $Duration.start()

func _on_duration_timeout() -> void:
    PlayerAttributes.speed_multiplier = 1.0
    PlayerAttributes.damage_multiplier = 1.0
