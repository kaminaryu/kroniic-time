extends Node2D

@export var spread: float = 15.0
@export var cooldown: float = 0.15

var card_scene := preload("res://src/skills/baelz/card.tscn")
var is_pressing := false
var cooling_down := false

func _ready() -> void :
    randomize()


func _input(event: InputEvent) -> void :
    if (event is not InputEventMouseButton) :
        return
        
    if (event.button_index == MOUSE_BUTTON_LEFT) :
        is_pressing = event.pressed
            
    
func _process(delta: float) -> void :
    if (is_pressing and not cooling_down) :
        var mouse_pos := get_global_mouse_position()
        var aim_rotation := atan2(mouse_pos.y - global_position.y, mouse_pos.x - global_position.x)
        var card := card_scene.instantiate()
        
        randf_range(-spread, spread)
        
        card.direction = Vector2.RIGHT.rotated(aim_rotation + deg_to_rad( randf_range(-spread, spread) ) )
        card.position = global_position 
        card.rotation = aim_rotation + PI/2
        card.scale = Vector2(1, 1)
        card.shooter = self
        
        # change the texture of the cards randomly
        card.get_node("CardFaces").frame = randi_range(0, 1)
        #card.get_node("Sprite2D").modulate = Color8(255, 0, 0)
        
        get_tree().root.add_child(card)
        
        $Timer.wait_time = cooldown
        $Timer.start()
        cooling_down = true
        
        


func _on_timer_timeout() -> void:
    cooling_down = false
