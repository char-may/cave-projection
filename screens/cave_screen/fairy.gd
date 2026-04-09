extends Node

@onready var sprite = $Sprite2D

# set random flicker speed
var flicker_min_speed = 2.0
var flicker_max_speed = 1.0

# set random scale
var min_scale = 0.015
var max_scale = 0.020

func _ready() -> void:
	# set sprite alpha to 0
	sprite.self_modulate.a = 0.0
	
	# set sprite to random uniform scale
	var random_scale = randf_range(min_scale, max_scale)
	sprite.scale = Vector2.ONE * random_scale
	flicker()
	
func flicker() -> void:
	# Wait for random delay
	await get_tree().create_timer(randf_range(5.0, 10.0)).timeout
	
	# Set random parameters
	var random_duration = randf_range(flicker_min_speed, flicker_max_speed)
	var flicker_burst = randi_range(3, 10)
	
	# Do flicker burst cycle
	for i in range(flicker_burst):
		print("flicker " + str(i) + " start")
		var flicker_on = create_tween()
		flicker_on.tween_property(sprite, "self_modulate:a", .9,random_duration)
		await flicker_on.finished
		var flicker_off = create_tween()
		flicker_off.tween_property(sprite, "self_modulate:a", 0.25, random_duration)
		await flicker_off.finished
		print("flicker " + str(i) + " finished")
	
	var flicker_reset = create_tween()
	flicker_reset.tween_property(sprite, "self_modulate:a", 0.0, random_duration)
	await flicker_reset.finished
	
	# Once finished, jump to a random position and restart flicker
	var x = randf_range(0, 1920)
	var y = randf_range(0, 1080)
	self.position = Vector2(x, y)
	
	print("Re-flickering")
	flicker()
