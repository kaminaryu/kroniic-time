extends Area2D

var _damage: int

var direction: Vector2
var speed: int =  676

func _physics_process(delta: float) -> void:
    global_position += Vector2.RIGHT.rotated(rotation) * delta * speed


func set_damage(dmg: float) -> void :
    _damage = dmg
    
func get_damage() -> int :
    return _damage
    

func _on_lifespan_timeout() -> void:
    queue_free()
