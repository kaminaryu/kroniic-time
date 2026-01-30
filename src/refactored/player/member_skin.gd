extends Node2D

func _process(delta: float) -> void :
    #var choice: int = $CanvasLayer/MarginContainer/MarginContainer/VSlider.value
    var selected_member: String = SquadHandler.get_member()
    var character: Node
    
    $Baelz.visible = false
    $Fauna.visible = false
    $Mumei.visible = false
    $Sana.visible  = false
    
    if (selected_member == "Baelz") :
        character = $Baelz
    elif (selected_member == "Fauna") :
        character = $Fauna
    elif (selected_member == "Mumei") :
        character = $Mumei
    elif (selected_member == "Sana") :
        character = $Sana

    var is_idle = get_parent().get_idle_status()
    character.visible = true
    character.get_node("Idle").visible = is_idle
    character.get_node("Walking").visible = not is_idle
