extends Area2D

func _ready() -> void :
    $SlashSprites.modulate.a = 0
    $DamageHitbox.disabled = true
    
    
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
    print(body.name)
    if (body.is_in_group("Slimes")) :
        if (body.on_air) :
            return
            
        var source_of_dmg = get_parent().get_parent()
        body.take_damage(source_of_dmg) # player is the source of damage 
        
