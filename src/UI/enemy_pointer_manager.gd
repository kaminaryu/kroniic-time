extends Node2D

var pointers_and_targets: Dictionary[Node, Node]

var pointer_scene: PackedScene = preload("res://src/UI/enemy_pointer.tscn")

func generate_pointers() -> void :
    var player: Node = get_tree().root.get_node("Main/Player")
    
    pointers_and_targets.clear()
    
    print("Init pointers..")
    
    for enemy in get_tree().get_nodes_in_group("Enemies") :
        var pointer: Node = pointer_scene.instantiate()
        
        pointer.target = enemy
        get_tree().root.add_child(pointer)
        
        pointers_and_targets[pointer] = enemy
        
        
func _process(delta: float) -> void :
    for pointer in pointers_and_targets :
        var enemy: Node = pointers_and_targets[pointer]
        
        if (not is_instance_valid(enemy)) :
            print("Freeing pointer cuz enemy died")
            pointer.queue_free()
            pointers_and_targets.erase(pointer)
    
