extends Node

var slime_scene = preload("res://src/enemies/slimes.tscn")
var darty_scene = preload("res://src/enemies/darty.tscn")

func _ready() -> void :
    randomize()
    
    
func _input(event: InputEvent) -> void :
    if (event is InputEventMouseButton) :
        if (event.pressed and event.button_index == MOUSE_BUTTON_MIDDLE) :
            var option := randi_range(0, 1)
            var enemy: Node
            
            if (option == 0) :
                enemy = slime_scene.instantiate()
            elif (option == 1) :
                enemy = darty_scene.instantiate()
                
            enemy.position = Vector2(676, 67)
            get_tree().root.add_child(enemy)
                
