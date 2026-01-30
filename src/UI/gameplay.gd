extends Control

func _process(delta: float) -> void:
    if (SquadHandler.get_member() == null) :
        return
        
    update_time()
    update_ultbar()
    update_squad_circles()
    update_skill_cooldown()
    

func update_time() -> void :
    $KroniiBar/TextureProgressBar.max_value = Kronii.MAX_TIME
    $KroniiBar/TextureProgressBar.value = Kronii.time_left

func update_ultbar() -> void :
    var current_member: String = SquadHandler.get_member()
    var value: int = SkillsStatisticHandler.ultimate_energy[current_member]["Current"]
    var max_value: int = SkillsStatisticHandler.ultimate_energy[current_member]["Max"]
    
    $UltBar/TextureProgressBar.max_value = max_value
    $UltBar/TextureProgressBar.value = value
    if value >= max_value:  $UltBar/Flashing.visible = true
    else:  $UltBar/Flashing.visible = false

func update_squad_circles() -> void :
    $Squad/HBoxContainer/Baelz.max_value = SkillsStatisticHandler.ultimate_energy["Baelz"]["Max"]
    $Squad/HBoxContainer/Baelz.value = SkillsStatisticHandler.ultimate_energy["Baelz"]["Current"]
    
    $Squad/HBoxContainer/Fauna.max_value = SkillsStatisticHandler.ultimate_energy["Fauna"]["Max"]
    $Squad/HBoxContainer/Fauna.value = SkillsStatisticHandler.ultimate_energy["Fauna"]["Current"]

    $Squad/HBoxContainer/Mumei.max_value = SkillsStatisticHandler.ultimate_energy["Mumei"]["Max"]
    $Squad/HBoxContainer/Mumei.value = SkillsStatisticHandler.ultimate_energy["Mumei"]["Current"]
 
    $Squad/HBoxContainer/Sana.max_value = SkillsStatisticHandler.ultimate_energy["Sana"]["Max"]
    $Squad/HBoxContainer/Sana.value = SkillsStatisticHandler.ultimate_energy["Sana"]["Current"]
    
    
var prev_member: String = "Hi"
func update_skill_cooldown() -> void :
    var skill := 0
    var member: String = SquadHandler.get_member()  
    
    if (member != prev_member) :
        $SkillCircle/Baelz.visible = false
        $SkillCircle/Fauna.visible = false
        $SkillCircle/Mumei.visible = false
        $SkillCircle/Sana.visible = false
        
        var skill_circle: String = "SkillCircle/" + member
        get_node(skill_circle).visible = true
        
    prev_member = member
    
    # if the timer doesnt exist a.k.a havent run the skill
    # thus the skill is obv not in cooldown
    var timer: Timer = SkillsStatisticHandler.timer_running[member][skill]
    if (timer == null) :
        $SkillCircle/Overlay.value = 0
        return
    
    var cooldown_time = SkillsStatisticHandler.skills_cooldown[member][skill]
    
    $SkillCircle/Overlay.max_value = cooldown_time
    $SkillCircle/Overlay.value = timer.time_left
