extends Control

func _process(delta: float) -> void:
    update_time()
    update_ultbar()
    

func update_time() -> void :
    $KroniiBar/TextureProgressBar.max_value = Kronii.MAX_TIME
    $KroniiBar/TextureProgressBar.value = Kronii.time_left

func update_ultbar() -> void :
    var current_member: String = SquadHandler.selected_member
    var value: int = SkillsStatisticHandler.ultimate_energy[current_member]["Current"]
    var max_value: int = SkillsStatisticHandler.ultimate_energy[current_member]["Max"]
    
    $UltBar/TextureProgressBar.max_value = max_value
    $UltBar/TextureProgressBar.value = value
