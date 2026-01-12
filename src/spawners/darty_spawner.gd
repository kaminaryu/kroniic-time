extends Node2D

var darty = preload("res://src/enemies/darty.tscn")


func spawn_darties(rooms : Array[Rect2], player_room, spawn_num):
	var darties = []
	for room in rooms:
		var random_num = randi_range(0, 10)
		if(room == player_room or random_num > 5):
			continue
		var spawn_pos = room.get_center()*32
		for i in range(darties.size(), darties.size() + spawn_num):
			darties.append(darty.instantiate())
			add_child(darties[i])
			darties[i].position = spawn_pos
