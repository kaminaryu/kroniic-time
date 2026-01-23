extends Node2D
class_name EntityAttributes

@export var _health: float

func take_damage(damage: int) -> void :
    _health -= damage
    print(get_parent().name + " have been hit a ", damage, "damages attack")

func get_health() -> float :
    return _health
    
