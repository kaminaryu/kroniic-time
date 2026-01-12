extends Node

const max_skill_cooldown: Dictionary[String, Array] = {
    "Baelz": [69, 0],
    "Fauna": [69, 0],
    "Mumei": [69, 0],
    "Sana" : [69, 0]
}

var current_skill_cooldown: Dictionary[String, Array] = {
    "Baelz": [0, 0],
    "Fauna": [0, 0],
    "Mumei": [0, 0],
    "Sana" : [0, 0]
}

var ultimate_energy: Dictionary[String, Dictionary] = {
    "Baelz": {
        "Current": 0,
        "Max": 100
    },
    "Fauna": {
        "Current": 0,
        "Max": 100
    },
    "Mumei": {
        "Current": 0,
        "Max": 100
    },
    "Sana" : {
        "Current": 0,
        "Max": 100
    }
}


func use_skill(member: String, skill: int) -> int:
    if (current_skill_cooldown[member][skill] > 0) :
        return -1
        
    current_skill_cooldown[member][skill] = max_skill_cooldown[member][skill]
    return 0
    
    
func use_ultimate(member: String) -> int :
    if (ultimate_energy[member]["Current"] < ultimate_energy[member]["Max"]) :
        return -1
        
    ultimate_energy[member]["Current"] = 0
    return 0


func _process(delta: float) -> void:
    ultimate_energy["Mumei"]["Current"] += 0.012
    ultimate_energy["Baelz"]["Current"] += 0.8
