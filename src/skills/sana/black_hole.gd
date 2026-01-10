extends Node2D

const DRAG_SPEED = 10000
var enemies: Array[Node]                                                                                                           

func _process(delta: float) -> void :
    for enemy in enemies :
        if (enemy == null) :
            return
            
        var direction = atan2(global_position.y - enemy.global_position.y, global_position.x - enemy.global_position.x)
        var new_pos = Vector2.RIGHT.rotated(direction) * delta * DRAG_SPEED * (256 - enemy.global_position.distance_to(global_position))*0.0005
        
        enemy.global_position += new_pos 
        
        enemy.get_node("EnemiesSharedAttributes").in_blackhole = true
        #enemy.move_and_slide()


func _on_body_entered(body: Node2D) -> void:
    if (not body.is_in_group("Enemies")) :
        return
    
    enemies.append(body)


#func _on_body_exited(body: Node2D) -> void:
    #if (not body.is_in_group("Enemies")) :
        #return
        #
    #if (body) :
        #enemies.erase(body)


func _on_timer_timeout() -> void:
    for enemy in enemies :
        if (enemy == null) :
            return
            
        enemy.get_node("EnemiesSharedAttributes").in_blackhole = false

    queue_free()
