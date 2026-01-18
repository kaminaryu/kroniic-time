extends Node2D

func _process(delta: float) -> void :
    var choice: int = $CanvasLayer/MarginContainer/MarginContainer/VSlider.value
    var character: Node
    
    $Baelz.visible = false
    $Fauna.visible = false
    $Mumei.visible = false
    $Sana.visible = false
    
    if (choice == 1) :
        character = $Baelz
    elif (choice == 2) :
        character = $Fauna
    elif (choice == 3) :
        character = $Mumei
    elif (choice == 4) :
        character = $Sana

    var is_idle = get_parent().get_idle_status()
    character.visible = true
    character.get_node("Idle").visible = is_idle
    character.get_node("Walking").visible = not is_idle
