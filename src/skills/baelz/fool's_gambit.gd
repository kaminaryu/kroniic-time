extends Node2D

@onready var label = $"../Multiplier"

func _ready() -> void :
    randomize()
        
func run() -> void :
    roll_d10()
    $AudioStreamPlayer2D.playing = true
        
func roll_d10() -> void :
        #1-5 : Debuff
        #6-20 : Buff
        var dice = randi_range(1, 20)
        
        label.text = "Dice20: " + str(dice)
        
        if (dice < 6) :
            PlayerAttributes.change_attribute("Speed", 1 - (0.1 * (5 - dice)), 5)
            PlayerAttributes.change_attribute("Damage", 1 - (0.1 * (5 - dice)), 5)
        else :
            PlayerAttributes.change_attribute("Speed", 1 + (0.1 * dice), 5)
            PlayerAttributes.change_attribute("Damage", 1 + (0.1 * dice), 5)
            
        
        $Duration.start()

func _on_duration_timeout() -> void:
    label.text = ""
    #PlayerAttributes.speed_multiplier = 1.0
    #PlayerAttributes.damage_multiplier = 1.0
