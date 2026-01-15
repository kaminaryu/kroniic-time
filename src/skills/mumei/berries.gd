extends Node2D

func run() -> void :
    eating_berries()    
    
func eating_berries() -> void :
        print("eatring berrues")
        PlayerAttributes.change_attribute("Speed", 1.5, 3)
        PlayerAttributes.change_attribute("Damage", 1.5, 3)
        
