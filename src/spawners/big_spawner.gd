extends Node2D

var giant = preload("res://src/enemies/giant.tscn")


func spawn_darties(rooms : Array[Rect2], player_room, spawn_num):
	var giants = []
	for room in rooms:
		var random_num = randi_range(0, 20)
		if(room == player_room or random_num > 5):
			continue
		var spawn_pos = room.get_center()*32
		for i in range(giants.size(), giants.size() + spawn_num):
			giants.append(giant.instantiate())
			add_child(giants[i])
			giants[i].position = spawn_pos
