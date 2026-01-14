extends Node

const MAX_TIME := 180
var time_left := 180

var timer: Timer

func _ready() -> void :
    timer = Timer.new()
    add_child(timer)
    
    timer.wait_time = 1
    timer.timeout.connect(on_timer_timeout)
    timer.start()

    
func on_timer_timeout() -> void :
    print(time_left)
    print(SceneManager.current_scene.name)
    if (SceneManager.current_scene.name != "Main") :
        return
    time_left -= 50
    if (time_left <= 0) :
        SceneManager.game_over()
        return
            
    timer.start()


func reset() -> void :
    time_left = MAX_TIME
