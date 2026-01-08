extends Area2D

@onready var speed := 670
var direction: Vector2
var source_of_fire: Node # set at gun.gd

func _physics_process(delta: float) -> void :
    position += direction * delta * speed
    


func _on_body_entered(body: Node2D) -> void:
    if (body.is_in_group("Slimes")) :
        if (body.on_air) :
            return
        
        body.take_damage(source_of_fire, 32, 1)
        
    elif (body.is_in_group("Giants")) :
        body.take_damage(source_of_fire, 32, 1)
        
    queue_free()
