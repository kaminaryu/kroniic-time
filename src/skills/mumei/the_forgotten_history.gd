extends Node2D

const TIME_LIMIT = 10000#ms

func _input(event: InputEvent) -> void :
    if (event is not InputEventKey) :
        return
        
    if (Input.is_action_just_pressed("ultimate")) :
        eradicate()
            
            
func eradicate() -> void :
    var on_screen_enemies := get_tree().get_nodes_in_group("Enemies").filter(
        func(enemy): return enemy.get_node("EnemiesSharedAttributes").is_on_screen
    )
    
    for enemy in on_screen_enemies :
        var time_spawned: int = enemy.get_node("EnemiesSharedAttributes").time_spawned
        
        print(enemy.name, " time left: ", Time.get_ticks_msec() - time_spawned)
        
        if (Time.get_ticks_msec() - time_spawned > TIME_LIMIT) :
            enemy.queue_free()
