extends Area2D

@onready var speed := 676
@onready var damage: float = 0.1

var direction: Vector2
var shooter: Node # for knowing whos 
#var source_of_fire: Node # set at gun.gd

func _physics_process(delta: float) -> void :
    position += direction * delta * speed

func _on_body_entered(body: Node2D) -> void:
    queue_free()


func _on_lifetime_timeout() -> void:
    queue_free()
