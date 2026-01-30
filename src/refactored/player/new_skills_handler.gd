extends Node2D

@onready var hand: Node = get_parent().get_node("Hand")

func _ready() -> void :
    #SquadHandler.changing_member.connect(change_skillset)
    pass
    
    
func _process(delta: float) -> void :
    var member: String = SquadHandler.get_member()
    var basic_attack: Node = get_node(member).get_node("Basic")
    
    basic_attack.global_position = hand.global_position
    basic_attack.rotation = hand.rotation


func _input(event: InputEvent) -> void :
    if (event.is_action_pressed("skill1")) :
        var member: String = SquadHandler.get_member()
        if (SkillsStatisticHandler.is_skill_avaiable(member)) :
            get_node(member).get_node("Skill").get_child(0).run()
        else :
            print(member, "'s skill unavailable")

        
    if (event.is_action_pressed("ultimate")) :
        var member: String = SquadHandler.get_member()
        if (SkillsStatisticHandler.is_ultimate_available(member)) :
            get_node(member).get_node("Ultimate").get_child(0).run()
        else :
            print("Ultimate ", member, " unavailable")   


#func change_skillset() -> void :
