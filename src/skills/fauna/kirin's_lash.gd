extends Node2D

@export var spread: float = 0.0
const COOLDOWN: float = 0.6 

var cooling_down := false

var leaf_scene := preload("res://src/skills/fauna/leaf.tscn")

var is_clicking = false

func _input(event: InputEvent) -> void :
    if event is not InputEventMouseButton :
        return
        
    if event.button_index == MOUSE_BUTTON_LEFT :
        if (event.pressed) :
            is_clicking = true
        else :
            is_clicking = false
            

func _process(delta: float) -> void :
    if (is_clicking and not cooling_down) :
        var mouse_pos := get_global_mouse_position()
        var aim_rotation := atan2(mouse_pos.y - global_position.y, mouse_pos.x - global_position.x)
        var leaf := leaf_scene.instantiate()
        
        leaf.direction = Vector2.RIGHT.rotated(aim_rotation)
        leaf.position = global_position
        leaf.rotation = aim_rotation + PI/2
        #leaf.source_of_fire = self.get_parent().get_parent() # player
        
        get_tree().root.add_child(leaf)
        
        cooling_down = true
        $Timer.wait_time = COOLDOWN
        $Timer.start()
        
        
func _on_timer_timeout() -> void:
    cooling_down = false
