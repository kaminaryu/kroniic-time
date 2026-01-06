extends Node2D

# i have an idea :
#   a singleton that handles weapon and shit
#   but ig thats for if we want a member to have multiple attacks, idk

# member specific weaponary
@export var basic_attack: PackedScene

var basic_attack_node: Node

func entered_tree() -> void:
    # if no basic attack lol
    if (basic_attack == null) :
        return
        
    # init the skills when entered the tree
    basic_attack_node = basic_attack.instantiate()
    
    var player := get_parent().get_parent().get_parent()
    player.get_node("Hand").add_child( basic_attack_node )


func exited_tree() -> void:
    if (basic_attack == null) :
        return
    basic_attack_node.queue_free()
