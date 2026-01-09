extends Area2D

@onready var speed := 670
var direction: Vector2
var source_of_fire: Node # set at gun.gd

func _physics_process(delta: float) -> void :
    position += direction * delta * speed
    

func _on_body_entered(body: Node2D) -> void:
    queue_free()
