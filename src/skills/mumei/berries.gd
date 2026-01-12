extends Node2D

func run() -> void :
    eating_berries()    
    
func eating_berries() -> void :
        print("eatring berrues")
        PlayerAttributes.speed_multiplier = 1.5
        PlayerAttributes.damage_multiplier = 1.5
        
        $Duration.start()

func _on_duration_timeout() -> void:
    PlayerAttributes.speed_multiplier = 1.0
    PlayerAttributes.damage_multiplier = 1.0
