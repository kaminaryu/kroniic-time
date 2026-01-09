extends Area2D

const DASH_LERP := 0.2
const CHARGING_TIME := 1.0
const COOLDOWN := 2.0 
const MAX_DETECT_RANGE := 512
const MAX_RETENTION_RANGE := 768

var target_pos: Vector2
var target_found: bool = false
var is_dashing: bool = false
var cooling_down: bool = false
var player: Node


func _ready() -> void :
	randomize()
	
	player = get_tree().root.get_node("Main/Player")
	

func _process(delta: float) -> void :
	#print("CD, TF, DSH: ", cooling_down, " | ", target_found, " | ", is_dashing)
	if (cooling_down) :
		$Sprite2D.modulate = Color8(67, 67, 67)
		return
	
	$Sprite2D.modulate = Color8(255, 255, 255)
	
		
	if (target_found) :
		if (is_dashing) :
			dash()
		else :
			target_pos = player.global_position
			look_at(target_pos)
			# if player is too far away
			if (!is_in_retention_range()) :
				target_found = false
				$Timer.stop()
				
		
	else :
		target_pos = player.global_position
		find_target()
		
	
func find_target() -> void :
	if (global_position.distance_to(target_pos) < MAX_DETECT_RANGE) :
		target_found = true
		$Timer.wait_time = randf_range(CHARGING_TIME, CHARGING_TIME + 2.0)
		$Timer.start()
	else :
		rotation += -PI/32
	

func is_in_retention_range() -> bool :
	if (global_position.distance_to(target_pos) > MAX_RETENTION_RANGE) :
		return false
	return true


func dash() -> void :
	global_position = global_position.lerp(target_pos, DASH_LERP)
	
	if (global_position.distance_to(target_pos) < 2) :
		stop_dashing()

func stop_dashing() -> void :
		is_dashing = false
		target_found = false
		cooling_down = true
		$Timer.wait_time = randf_range(COOLDOWN, COOLDOWN + 1)
		$Timer.start()
		

#region SIGNALS
func _on_timer_timeout() -> void:
	# when done cooling down after attacking
	if (cooling_down) :
		cooling_down = false
	# when done charging up
	else :
		is_dashing = true
	#get_random_target()


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player") :
		stop_dashing()
		body.take_damage(self, 128, 20)
		#get_tree().quit()

#endregion
