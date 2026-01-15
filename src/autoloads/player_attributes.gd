extends Node

var speed_multiplier := 1.0
var damage_multiplier := 1.0

func reset() -> void :
    speed_multiplier = 1.0
    damage_multiplier = 1.0



func change_attribute(attr, value, time) -> void :
    print("running")
    if (attr == "Speed") :
        speed_multiplier += value
        print("speed")
    elif (attr == "Damage") :
        print("damage")
        damage_multiplier += value
    pass
    var timer = Timer.new()
    timer.wait_time = time
    timer.timeout.connect(
        func() :
            if (attr == "Speed") :
                speed_multiplier -= value
            elif (attr == "Damage") :
                damage_multiplier -= value
            timer.queue_free()
            print("death")
    )
    
    get_tree().root.add_child(timer)
    timer.start()
