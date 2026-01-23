extends Area2D
class_name TakingDamageComponent

@export var HitBoxSize: Vector2
var entity_attributes: Node

func _ready() -> void :
    $CollisionShape2D.shape.size = HitBoxSize
    
    for sibling in get_parent().get_children() :
        if (sibling is EntityAttributes) :
            entity_attributes = sibling

func inflict_damage(damage) -> void :
    entity_attributes.take_damage(damage)
    var health: float = entity_attributes.get_health()
    print("Player have ", health , " healths left.")

func _on_area_entered(area: Area2D) -> void:
    if (area.has_method("get_damage")) :
        var damage = area.get_damage()
        inflict_damage(damage)
    
    if (area.has_method("has_hit_smth")) :
        area.has_hit_smth()
