extends Area2D

var enemies: Array[Node]

func _input(event: InputEvent) -> void :
    if (event is not InputEventKey) :
        return
    
    if (event.is_action_pressed("skill1")) :
        explode()
        

func explode() -> void :
    var player := get_tree().root.get_node("Main/Player")
    var direction_away: float
    
    $Explosion.emitting = true
    
    for enemy in enemies :
        if (not enemies) :
            return
        #var player_pos = player.global_position
        #var enemy_pos  = enemy.global_position
        
        # for now ts is the solution for ease,
        #enemy.take_damage(player, 256, 0)
        enemy.knock_back(player, 256)
    
    enemies.clear()
    

func _on_body_entered(body: Node2D) -> void:
    if (body.is_in_group("Enemies")) :
        enemies.append(body)

func _on_body_exited(body: Node2D) -> void:
    if (body.is_in_group("Eemies")) :
        enemies.erase(body)
