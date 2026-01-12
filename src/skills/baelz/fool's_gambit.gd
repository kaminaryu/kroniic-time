extends Node2D

func _ready() -> void :
    randomize()
        
func run() -> void :
    roll_d10()
        
func roll_d10() -> void :
        #1-5 : Debuff
        #6-20 : Buff
        var dice = randi_range(1, 20)
        print("Baelz has thrown a nat ", dice)
        
        if (dice < 6) :
            PlayerAttributes.speed_multiplier = 1 - (0.1 * (5 - dice))
            PlayerAttributes.damage_multiplier = 1 - (0.1 * (5 - dice))
        else :
            PlayerAttributes.speed_multiplier = 1 + (0.1 * dice)
            PlayerAttributes.damage_multiplier = 1 + (0.1 * dice)
            
        
        $Duration.start()

func _on_duration_timeout() -> void:
    PlayerAttributes.speed_multiplier = 1.0
    PlayerAttributes.damage_multiplier = 1.0
