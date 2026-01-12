extends Node

@export var dungeon_generator : Node2D

var level = 1

var level_finished = false

func get_enemy_count() -> int:
	return get_tree().get_nodes_in_group("Enemies").size()

func get_slime_spawn_amount(current_level) -> int:
	# Starts at 4, increases by 1 every 2 levels
	return 4 + (current_level - 1)/2
	
func get_darties_spawn_amount(current_level) -> int:
	# Starts at 4, increases by 1 every 2 levels
	return (current_level - 1) / 2

func _process(delta: float) -> void:
	var count = get_enemy_count()
	if(count <= 0 and !level_finished):
		level += 1
		level_finished = true
		dungeon_generator.create_noise()
		dungeon_generator.create_dungeon(level)
		level_finished = false
