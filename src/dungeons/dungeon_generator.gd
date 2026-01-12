extends Node2D
 
@export var tilemap : TileMapLayer
@export var player : CharacterBody2D
@export var slime_spawner: Node2D
@export var darty_spawner: Node2D
@export var level_manager: Node2D

const DUNGEON_WIDTH = 100
const DUNGEON_HEIGHT = 100

const MIN_ROOM_WIDTH = 16
const MAX_ROOM_WIDTH = 24
const MIN_ROOM_HEIGHT = 16
const MAX_ROOM_HEIGHT = 24
 
enum TileType { EMPTY, FLOOR, WALL }
 
var dungeon_grid = []
var noise: FastNoiseLite

func _ready():
	create_noise()
	create_dungeon(1)

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_0:
			create_dungeon(1)
 
func generate_dungeon(max_rooms):
	dungeon_grid = []
	for y in DUNGEON_HEIGHT:
		dungeon_grid.append( [] )
		for x in DUNGEON_WIDTH:
			dungeon_grid[y].append( TileType.EMPTY )
 
	var rooms : Array[Rect2] = []
	var max_attempts = 20
	var tries = 0
 
	while rooms.size() < max_rooms and tries < max_attempts:
		var w = randi_range(MIN_ROOM_WIDTH, MAX_ROOM_WIDTH)
		var h = randi_range(MIN_ROOM_HEIGHT, MAX_ROOM_HEIGHT)
		var x = randi_range(1, DUNGEON_WIDTH - w - 1)
		var y = randi_range(1, DUNGEON_HEIGHT - h - 1)
		var room = Rect2(x, y, w, h)
 
		var overlaps = false
		for other in rooms:
			if room.grow(1).intersects(other):
				overlaps = true
				break
 
		if !overlaps:
			rooms.append(room)
			for iy in range(y, y + h):
				for ix in range(x, x + w):
					dungeon_grid[iy][ix] = TileType.FLOOR
			if rooms.size() > 1:
				var prev = rooms[rooms.size() - 2].get_center()
				var curr = room.get_center()
				carve_corridor(prev, curr)
 
		tries += 1
 
	return rooms
 
func carve_corridor(from: Vector2, to: Vector2, width: int = 4):
	var min_width = -width / 2
	var max_width = width / 2
 
	if randf() < 0.5:
		for x in range(min(from.x, to.x), max(from.x, to.x) + 1):
			for offset in range(min_width, max_width + 1):
				var y = from.y + offset
				if is_in_bounds(x, y):
					dungeon_grid[y][x] = TileType.FLOOR
 
		for y in range(min(from.y, to.y), max(from.y, to.y) + 1):
			for offset in range(min_width, max_width + 1):
				var x = to.x + offset
				if is_in_bounds(x, y):
					dungeon_grid[y][x] = TileType.FLOOR
	else:
		for y in range(min(from.y, to.y), max(from.y, to.y) + 1):
			for offset in range(min_width, max_width + 1):
				var x = from.x + offset
				if is_in_bounds(x, y):
					dungeon_grid[y][x] = TileType.FLOOR
 
		for x in range(min(from.x, to.x), max(from.x, to.x) + 1):
			for offset in range(min_width, max_width + 1):
				var y = to.y + offset
				if is_in_bounds(x, y):
					dungeon_grid[y][x] = TileType.FLOOR
 
func is_in_bounds(x: int, y: int) -> bool:
	return x >= 0 and y >= 0 and x < DUNGEON_WIDTH and y < DUNGEON_HEIGHT
 
func add_walls():
	for y in range(DUNGEON_HEIGHT):
		for x in range(DUNGEON_WIDTH):
			if dungeon_grid[y][x] == TileType.FLOOR:
				for dy in range(-1, 2):
					for dx in range(-1, 2):
						var nx = x + dx
						var ny = y + dy
						if nx >= 0 and ny >= 0 and nx < DUNGEON_WIDTH and ny < DUNGEON_HEIGHT:
							if dungeon_grid[ny][nx] == TileType.EMPTY:
								dungeon_grid[ny][nx] = TileType.WALL
 
func render_dungeon():
	tilemap.clear()
	for y in range(DUNGEON_HEIGHT):
		for x in range(DUNGEON_WIDTH):
			var tile = dungeon_grid[y][x]
			
			match tile:
				TileType.FLOOR:
					tilemap.set_cell(Vector2i(x, y), 2, Vector2i(get_tile_index(x, y), 1))
				TileType.WALL:
					var wall_atlas_coords = get_wall_variant(x, y)
					tilemap.set_cell(Vector2i(x, y), 2, wall_atlas_coords)
 
func create_dungeon(current_level):
	var dungeon = generate_dungeon(randi_range(1, 4) + current_level)
	var player_room = place_player(dungeon)
	var slime_spawn_amount = level_manager.get_slime_spawn_amount(current_level)
	var darties_spawn_amount = level_manager.get_darties_spawn_amount(current_level)
	slime_spawner.spawn_slimes(dungeon, player_room, slime_spawn_amount)
	darty_spawner.spawn_darties(dungeon, player_room, darties_spawn_amount)
	
	print("Spawning ", slime_spawn_amount, " Slimes")
	print("Spawning ", darties_spawn_amount, " Darties")
	add_walls()
	render_dungeon()
 
func place_player(rooms : Array[Rect2]):
	var player_room = rooms.pick_random()
	player.position = player_room.get_center() * 32
	return player_room



func create_noise():
	noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.fractal_octaves = 4
	noise.frequency = 0.05
	
func get_tile_index(x: int, y: int) -> int:
	var raw_noise = noise.get_noise_2d(x, y)
	var n = remap(raw_noise, -1.0, 1.0, 0.0, 1.0)
	
	if n < 0.55:
		return 0
		
	elif n < 0.75:
		return randi_range(0, 6)
		
	else:
		return 7

func is_wall(x, y):
	# Check bounds to avoid errors
	if x < 0 or y < 0 or x >= DUNGEON_WIDTH or y >= DUNGEON_HEIGHT:
		return true # Treat out-of-bounds as walls for seamless edges
	return dungeon_grid[y][x] == TileType.WALL

func is_floor(x, y):
	# If out of bounds, it's definitely not a floor
	if x < 0 or y < 0 or x >= DUNGEON_WIDTH or y >= DUNGEON_HEIGHT:
		return false
	return dungeon_grid[y][x] == TileType.FLOOR

func get_wall_variant(x, y) -> Vector2i:
	var w_left  = is_wall(x - 1, y)
	var w_right = is_wall(x + 1, y)
	var w_up    = is_wall(x, y - 1)
	var w_down  = is_wall(x, y + 1)
	var f_left  = is_floor(x - 1, y)
	var f_right = is_floor(x + 1, y)
	var f_up    = is_floor(x, y - 1)
	var f_down  = is_floor(x, y + 1)

	if w_left and w_right:
		return Vector2i(1, 2)
	
	if w_up and w_down and f_left and f_right:
		return Vector2i(5,3)
	if w_up and w_down and f_right:
		return Vector2i(0,3)
	if w_up and w_down and f_left:
		return Vector2i(2,3)
	if w_up and w_down and f_right:
		return Vector2i(0,3)
		
	if w_left and w_up and f_right:
		return Vector2i(1, 2)
	if w_right and w_up and f_left:
		return Vector2i(1, 2)
	if w_up and w_right:
		return Vector2i(0, 4)
	if w_up and w_left:
		return Vector2i(2, 4)
		
	if w_left and w_down and f_right:
		return Vector2i(4, 3)
	if w_right and w_down and f_left:
		return Vector2i(3, 2)
	
	if w_down and w_right:
		return Vector2i(0,2)
	if w_down and w_left:
		return Vector2i(2,2)
		
	return Vector2i(1,1)
