extends Control

func _process(delta: float) -> void:
    update_time()
    update_ultbar()
    update_squad_circles()
    

func update_time() -> void :
    $KroniiBar/TextureProgressBar.max_value = Kronii.MAX_TIME
    $KroniiBar/TextureProgressBar.value = Kronii.time_left

func update_ultbar() -> void :
    var current_member: String = SquadHandler.selected_member
    var value: int = SkillsStatisticHandler.ultimate_energy[current_member]["Current"]
    var max_value: int = SkillsStatisticHandler.ultimate_energy[current_member]["Max"]
    
    $UltBar/TextureProgressBar.max_value = max_value
    $UltBar/TextureProgressBar.value = value

func update_squad_circles() -> void :
    $Squad/HBoxContainer/Baelz.max_value = SkillsStatisticHandler.ultimate_energy["Baelz"]["Max"]
    $Squad/HBoxContainer/Baelz.value = SkillsStatisticHandler.ultimate_energy["Baelz"]["Current"]
    
    $Squad/HBoxContainer/Fauna.max_value = SkillsStatisticHandler.ultimate_energy["Fauna"]["Max"]
    $Squad/HBoxContainer/Fauna.value = SkillsStatisticHandler.ultimate_energy["Fauna"]["Current"]

    $Squad/HBoxContainer/Mumei.max_value = SkillsStatisticHandler.ultimate_energy["Mumei"]["Max"]
    $Squad/HBoxContainer/Mumei.value = SkillsStatisticHandler.ultimate_energy["Mumei"]["Current"]
 
    $Squad/HBoxContainer/Sana.max_value = SkillsStatisticHandler.ultimate_energy["Sana"]["Max"]
    $Squad/HBoxContainer/Sana.value = SkillsStatisticHandler.ultimate_energy["Sana"]["Current"]
    
    
