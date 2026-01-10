extends Control

func _process(delta: float) -> void :
    $TextureProgressBar.value = Kronii.time_left
