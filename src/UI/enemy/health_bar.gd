extends Control

func _process(delta: float) -> void :
    var enemy: Node = get_parent()
    
    
    $TextureProgressBar.max_value = enemy.max_health
    $TextureProgressBar.value = enemy.health
    
