extends Node2D

var is_on_screen: bool = false
var time_spawned: int = 0
var frozen: bool = false
var in_blackhole: bool = false

func _ready() -> void :
    time_spawned = Time.get_ticks_msec()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
    is_on_screen = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    is_on_screen = false
