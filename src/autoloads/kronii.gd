extends Node

const MAX_TIME := 12000
var time_left := 120000

var timer: Timer

func _ready() -> void :
    timer = Timer.new()
    add_child(timer)
    
    timer.wait_time = 1
    timer.timeout.connect(on_timer_timeout)
    timer.start()

    
func on_timer_timeout() -> void :
    time_left -= 1
    if (time_left <= 0) :
        get_tree().quit()
    
    timer.start()
