extends Node


var squad_scenes: Dictionary[String,  PackedScene] = {
    "Baelz": preload("res://src/holo_council/baelz/baelz.tscn"),
    "Fauna": preload("res://src/holo_council/fauna/fauna.tscn"),
    "Mumei": preload("res://src/holo_council/mumei/mumei.tscn"),
    "Sana" : preload("res://src/holo_council/sana/sana.tscn")
}
var selected_member := "Mumei";
var member_node: Node

func _ready() -> void :
    change_squad_member(selected_member)
    
    
func _process(delta: float) -> void :
    
    if Input.is_action_just_pressed("change_squad_1") :
        change_squad_member("Baelz")
    elif Input.is_action_just_pressed("change_squad_2") :
        change_squad_member("Fauna")
    elif Input.is_action_just_pressed("change_squad_3") :
        change_squad_member("Mumei")
    elif Input.is_action_just_pressed("change_squad_4") :
        change_squad_member("Sana")
        
    
func change_squad_member(member: String) -> void :
    var member_controller := get_tree().root.get_node("Main/Player/MemberController")
    
    if member_node :
        member_node.queue_free()
        
    selected_member = member
    member_node = squad_scenes[selected_member].instantiate()
    
    # if not run by main / testing others
    if member_controller == null :
        return
        
    member_controller.add_child(member_node)
