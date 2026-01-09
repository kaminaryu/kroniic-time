extends Area2D

var damage: int
var knockback: int
@onready var player: Node = get_parent().get_parent()

func _ready() -> void :
    $SlashSprites.modulate.a = 0
    $DamageHitbox.disabled = true
    
    damage = player.damage * player.damage_modifier
    knockback = player.knockback
    
    
func _input(event: InputEvent) -> void :
    if event is InputEventMouseButton :
        if event.pressed and event.button_index == MOUSE_BUTTON_LEFT :
            #$SlashAnimation.visible = true;
            $AnimationPlayer.play("slashing")
            $DamageHitbox.disabled = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name == "slashing") :
        $DamageHitbox.disabled = true


func _on_body_entered(body: Node2D) -> void:
    print("We are damaging: ", body.name)
    var source_of_dmg = player
    
