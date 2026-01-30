extends Node

# Make the skills duration also in here

# cooldown (in sec) of every skills
var skills_cooldown: Dictionary[String, Array] = {
    "Baelz": [10, 0],
    "Fauna": [12, 0],
    "Mumei": [7, 0],
    "Sana" : [8, 0]
}

# current status of the skills, false == unavaiable
var skills_is_active: Dictionary[String, Array] = {
    "Baelz": [true, true],
    "Fauna": [true, true],
    "Mumei": [true, true],
    "Sana" : [true, true]
}


var ultimate_energy: Dictionary[String, Dictionary] = {
    "Baelz": {
        "Current": 50,
        "Max": 50
    },
    "Fauna": {
        "Current": 0,
        "Max": 40
    },
    "Mumei": {
        "Current": 0,
        "Max": 70
    },
    "Sana" : {
        "Current": 0,
        "Max": 60
    }
}


var timer_running: Dictionary = {
    "Baelz": [null, null],
    "Fauna": [null, null],
    "Mumei": [null, null],
    "Sana":  [null, null]
}



func is_skill_avaiable(member: String) -> bool:
    var skill = 0
    print(member, " is running skill ", skill)
    if (not skills_is_active[member][skill]) :
        return false
        
    skills_is_active[member][skill] = false
    
    var timer: Timer
    
    if (timer_running[member][skill] == null) :
        timer = Timer.new()
        timer_running[member][skill] = timer
        get_tree().root.add_child(timer)
        print("New timer spawned")
    else :
        timer = timer_running[member][skill]
        print("Re-using timer")
    
    timer.wait_time = skills_cooldown[member][skill]
    timer.one_shot = true
    timer.timeout.connect(
        func(): 
            skills_is_active[member][skill] = true
            print("Skill has finished cooldown")
    )
    timer.start()
    
    return true
    

func is_ultimate_available(member: String) -> bool :
    print(member, " is running ultimate")
    if (ultimate_energy[member]["Current"] < ultimate_energy[member]["Max"]) :
        return false
        
    ultimate_energy[member]["Current"] = 0
    return true


func get_cooldown(member: String, skill: int) -> Timer :
    if (timer_running[member][skill] == null) :
        return null
    
    return timer_running[member][skill]
    pass


func increase_energy() -> void :
    var member: String = SquadHandler.selected_member
    var amount: int = randi_range(6, 7)
    ultimate_energy[member]["Current"] += amount


#func _process(delta: float) -> void:
    #ultimate_energy["Mumei"]["Current"] += 0.032
    #ultimate_energy["Baelz"]["Current"] += 0.1
#
    #ultimate_energy["Sana"]["Current"] += 0.2
    #ultimate_energy["Fauna"]["Current"] += 0.4

func reset() -> void :
    skills_cooldown = {
        "Baelz": [10, 0],
        "Fauna": [12, 0],
        "Mumei": [7, 0],
        "Sana" : [8, 0]
    }

    skills_is_active = {
        "Baelz": [true, true],
        "Fauna": [true, true],
        "Mumei": [true, true],
        "Sana" : [true, true]
    }


    ultimate_energy = {
        "Baelz": {
            "Current": 50,
            "Max": 50
        },
        "Fauna": {
            "Current": 0,
            "Max": 40
        },
        "Mumei": {
            "Current": 0,
            "Max": 70
        },
        "Sana" : {
            "Current": 0,
            "Max": 60
        }
    }
    
    timer_running = {
        "Baelz": [null, null],
        "Fauna": [null, null],
        "Mumei": [null, null],
        "Sana":  [null, null]
    }
