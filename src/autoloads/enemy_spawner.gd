extends Node

var slime_scene = preload("res://src/enemies/slimes.tscn")
var darty_scene = preload("res://src/enemies/darty.tscn")
var giant_scene = preload("res://src/enemies/giant.tscn")

func _ready() -> void :
    randomize()
    
    
func _input(event: InputEvent) -> void :
    if (event is InputEventMouseButton) :
        if (event.pressed and event.button_index == MOUSE_BUTTON_MIDDLE) :
            var option := randi_range(0, 2)
            var enemy: Node
            
            if (option == 0) :
                enemy = slime_scene.instantiate()
            elif (option == 1) :
                enemy = darty_scene.instantiate()
            elif (option == 2) :
                enemy = giant_scene.instantiate()
                
            enemy.position = Vector2(676, 67)
            get_tree().root.add_child(enemy)
                
