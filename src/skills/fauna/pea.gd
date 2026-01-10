extends Area2D

@onready var speed := 500
@onready var damage_multiplier: float
@onready var dmg: float = 1.0

var direction: Vector2
var shooter: Node # for knowing whos 
var damage: float
#var source_of_fire: Node # set at gun.gd

func _physics_process(delta: float) -> void :
    position += direction * delta * speed
    damage = dmg * damage_multiplier

func _on_body_entered(body: Node2D) -> void:
    queue_free()
