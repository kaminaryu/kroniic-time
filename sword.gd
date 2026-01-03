extends Area2D

func _ready() -> void :
    $SlashSprites.modulate.a = 0
    
    
func _input(event: InputEvent) -> void :
    if event is InputEventMouseButton :
        if event.pressed and event.button_index == MOUSE_BUTTON_LEFT :
            #$SlashAnimation.visible = true;
            $AnimationPlayer.play("slashing")
            
