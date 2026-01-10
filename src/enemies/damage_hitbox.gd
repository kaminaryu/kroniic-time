extends Area2D

@export var hitbox: Vector2

func _ready() -> void :
    if $CollisionShape2D.shape:
        # create a duplicate so godot doesnt fucking uses the same reference
        $CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
        $CollisionShape2D.shape.size = hitbox

func _on_area_entered(area: Area2D) -> void:
    var knockback := 64
    var damage: float = area.damage
    
    var player: Node = get_tree().root.get_node("Main/Player")
        
    get_parent().take_damage(area, knockback, damage);
    
    print(get_parent().name + " is detecting " + area.name)
