extends Node2D

var slime = preload("res://src/enemies/slimes.tscn")


func spawn_slimes(rooms : Array[Rect2], player_room, spawn_num):
	var slimes = []
	for room in rooms:
		if(room == player_room):
			continue
		var spawn_pos = room.get_center()*32
		for i in range(slimes.size(), slimes.size() + spawn_num):
			slimes.append(slime.instantiate())
			add_child(slimes[i])
			slimes[i].position = spawn_pos
