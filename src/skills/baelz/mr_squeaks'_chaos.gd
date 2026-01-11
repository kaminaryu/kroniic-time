extends Node2D

var mr_s_scene := preload("res://src/skills/baelz/mr_squeaks.tscn")


func _ready() -> void :
    randomize()
    
func _input(event: InputEvent) -> void :
    if (event is not InputEventKey) :
        return
        
    if (Input.is_action_just_pressed("ultimate")) :
        spawn_mr_s()
        var total_time = randf_range(6.7, 10.7)
        $TotalTime.wait_time = total_time
        $TotalTime.start()
        #total_rats = randi_range(20, 40)
        
        
func spawn_mr_s() -> void :
    var mr_s = mr_s_scene.instantiate()
    var rand_dir = randf_range(0, TAU)
    
    #mr_s.global_position = get_global_mouse_position()
    mr_s.global_position = get_parent().global_position
    mr_s.target_pos = mr_s.global_position + Vector2.RIGHT.rotated(rand_dir) * randi_range(128, 256)
    get_tree().root.add_child(mr_s)
    
    var cooldown = randf_range(0.2, 0.5)
    $Cooldown.wait_time = cooldown
    $Cooldown.start()
    


func _on_cooldown_timeout() -> void:
    spawn_mr_s()


func _on_total_time_timeout() -> void:
    queue_free()
