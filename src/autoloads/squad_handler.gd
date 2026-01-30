extends Node

signal changing_member

var squad_scenes: Dictionary[String,  PackedScene] = {
    "Baelz": preload("res://src/holo_council/baelz/baelz.tscn"),
    "Fauna": preload("res://src/holo_council/fauna/fauna.tscn"),
    "Mumei": preload("res://src/holo_council/mumei/mumei.tscn"),
    "Sana" : preload("res://src/holo_council/sana/sana.tscn")
}
var _selected_member: String
var _member_node: Node


func _ready() -> void :
    reset()
    
func reset() -> void :
    _selected_member = " "
    change_squad_member("Mumei")
    
    
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
    # no more selecting already selected members
    if (member == _selected_member) :
        return
        
    var member_controller := get_tree().root.get_node("Main/Player/MemberController")
    
    if (_member_node) :
        _member_node.queue_free()
        
    _selected_member = member
    _member_node = squad_scenes[_selected_member].instantiate()
    
    # if not run by main / testing others
    if member_controller == null :
        return
        
    member_controller.add_child(_member_node)
    
    changing_member.emit()

func get_member() -> String :
    return _selected_member
