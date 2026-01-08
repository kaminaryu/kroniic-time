extends Area2D

var timer_started := false


func _ready() -> void :
    $SlashSprites.modulate.a = 0.0
    $DamageHitbox.disabled = true
    
func start_attacking() -> void :
    if (timer_started) :
        return
    
    timer_started = true
    $Timer.start()
    
func stop_attacking() -> void :
    timer_started = false
    $Timer.stop()
    
    
func start_slash() -> void :
    $AnimationPlayer.play("slashing")
    $DamageHitbox.disabled = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if (anim_name == "slashing") :
        $DamageHitbox.disabled = true
        $Timer.start()


func _on_body_entered(body: Node2D) -> void:
    if (body.name == "Player") :
        var source_of_dmg = get_parent()
        var knockback: int = 64
        var damage: int = 10
        body.take_damage(source_of_dmg, knockback, damage) # player is the source of damage 
        


func _on_timer_timeout() -> void:
    timer_started = false
    start_slash()
