extends Area2D

func _ready() -> void :
    $Lifespan.start()
    print('asjd')


func _process(delta: float) -> void :
    var player := get_tree().root.get_node("Main/Player")
    
    if (global_position.y < player.global_position.y) :
        z_index = player.z_index - 1
    else :
        z_index = player.z_index + 1


func _on_body_entered(body: Node2D) -> void:
    if (body.name == "Player") :
        if (SquadHandler.selected_member == "Fauna") :
            PlayerAttributes.damage_multiplier = 2.5
            #get_tree().root.get_node("Main/Player/MemberController").scale = Vector2(10.0, 10.0)
        else :
            PlayerAttributes.damage_multiplier = 2.0
            #get_tree().root.get_node("Main/Player/MemberController").scale = Vector2(5.0, 5.0)
            

func _on_body_exited(body: Node2D) -> void:
    if (body.name == "Player") :
        PlayerAttributes.damage_multiplier = 1.0
        get_tree().root.get_node("Main/Player/MemberController").scale = Vector2(2, 2)

    


func _on_timer_timeout() -> void:
    queue_free()


func _on_area_entered(area: Area2D) -> void:
    if (area.is_in_group("Saplings")) :
        area.damage_multiplier = 2.0
        #area.scale = Vector2(5, 5)


func _on_area_exited(area: Area2D) -> void:
    if (area.is_in_group("Saplings")) :
        area.damage_multiplier = 1.0
        #area.scale = Vector2(1.0, 1.0)
