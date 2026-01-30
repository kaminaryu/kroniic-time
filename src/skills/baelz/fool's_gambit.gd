extends Node2D

@onready var label_scn: PackedScene = preload("res://src/skills/baelz/d_20_label.tscn")

func _ready() -> void :
    randomize()
        
func run() -> void :
    roll_d10()
    $AudioStreamPlayer2D.playing = true
        
func roll_d10() -> void :
        #1-5 : Debuff
        #6-20 : Buff
        var dice = randi_range(1, 20)
        
        var label: Label = label_scn.instantiate()
        label.text = "Dice20: " + str(dice)
        get_tree().root.add_child(label)
        
        if (dice < 6) :
            PlayerAttributes.change_attribute("Speed", 1 - (0.1 * (5 - dice)), 5)
            PlayerAttributes.change_attribute("Damage", 1 - (0.1 * (5 - dice)), 5)
        else :
            PlayerAttributes.change_attribute("Speed", 1 + (0.1 * dice), 5)
            PlayerAttributes.change_attribute("Damage", 1 + (0.1 * dice), 5)
            
        
        $Duration.start()
