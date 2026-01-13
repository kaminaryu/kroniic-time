extends Node


var squad_scenes: Dictionary[String,  PackedScene] = {
	"Baelz": preload("res://src/holo_council/baelz/baelz.tscn"),
	"Fauna": preload("res://src/holo_council/fauna/fauna.tscn"),
	"Mumei": preload("res://src/holo_council/mumei/mumei.tscn"),
	"Sana" : preload("res://src/holo_council/sana/sana.tscn")
}
var selected_member: String
var member_node: Node
var readyy: bool = false
	
func reset() -> void :
	#readyy = false
	#var fuckass_shitass_bug = Timer.new()
	#fuckass_shitass_bug.wait_time = 0.1
	#fuckass_shitass_bug.start()
	#fuckass_shitass_bug.timeout.connect(
		#func():
			selected_member = " "
			change_squad_member("Mumei")
			#fuckass_shitass_bug.queue_free()
			#readyy = true
	#)
	#get_tree().root.add_child(fuckass_shitass_bug)
	#fuckass_shitass_bug.start()
	
	
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
	if (member == selected_member) :
		return
		
	var member_controller := get_tree().root.get_node("Main/Player/MemberController")
	
	if (member_node) :
		member_node.queue_free()
		
	selected_member = member
	member_node = squad_scenes[selected_member].instantiate()
	
	# if not run by main / testing others
	if member_controller == null :
		return
		
	member_controller.add_child(member_node)
