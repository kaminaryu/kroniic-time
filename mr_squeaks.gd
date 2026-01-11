extends Area2D

var enemies: Array[Node]
var target_pos: Vector2

func _process(delta: float) -> void :
    $CPUParticles2D.emitting = true
    
    if (global_position.distance_to(target_pos) > 4) :
        global_position = global_position.lerp(target_pos, 0.15)
        
        print(global_position, target_pos)


func explode() -> void:
    for enemy in enemies :
        if not enemy :
            return
            
        enemy.take_damage(self, 96, 5)
        
        if (enemy.is_in_group("Darty")) :
            enemy.knock_back(self, 96)
            
        
    $Explosion.emitting = true
    $DeathTimer.start()
    $Sprite2D.visible = false
        
    
    
func _on_count_down_timeout() -> void:
    explode()


func _on_body_entered(body: Node2D) -> void:
    if (body.is_in_group("Enemies")) :
        enemies.append(body)
        


func _on_body_exited(body: Node2D) -> void:
    if (body) :
        if (body.is_in_group("Enemies")) :
            enemies.erase(body)


func _on_death_timer_timeout() -> void:
    queue_free()
