extends Node2D

# member specific weaponary
@export var basic_attack_scene: PackedScene
@export var skill_1_scene : PackedScene
@export var skill_2_scene: PackedScene
@export var ultimate_scene : PackedScene

var basic_attack: Node
var skill_1: Node
var skill_2: Node
var ultimate: Node

func entered_tree() -> void:
    var player := get_parent().get_parent().get_parent()
    
    # Handle Basic Attack
    if (basic_attack_scene):
        basic_attack = basic_attack_scene.instantiate()
        player.get_node("Hand").add_child(basic_attack)
    else:
        print(get_parent().name + " has no basic attack")

    # Handle Skill 1
    if (skill_1_scene):
        skill_1 = skill_1_scene.instantiate()
        player.add_child(skill_1)
    else:
        print(get_parent().name + " has no skill 1")

    # Handle Skill 2
    if (skill_2_scene):
        skill_2 = skill_2_scene.instantiate()
        player.add_child(skill_2)
    else:
        print(get_parent().name + " has no skill 2")

    # Handle Ultimate
    if (ultimate_scene):
        ultimate = ultimate_scene.instantiate()
        player.add_child(ultimate)
    else:
        print(get_parent().name + " has no ultimate")


func exited_tree() -> void:
    if basic_attack: 
        basic_attack.queue_free()
    if skill_1:       
        skill_1.queue_free()
    if skill_2:       
        skill_2.queue_free()
    if ultimate:      
        ultimate.queue_free()
