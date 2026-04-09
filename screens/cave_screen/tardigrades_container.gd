extends Node

@onready var tardigrade_timer : Timer = $"../TardigradeTimer"

const max_tardigrades_on_screen : int = 6
var rng

var min_rotate_time: float = 15.0
var max_rotate_time: float = 35.0

func _ready() -> void:
	GlobalSignal.new_tardigrade_created.connect(create_tardigrade)
	rng = RandomNumberGenerator.new()
	rng.randomize()
	start_random_timer()
	
func create_tardigrade():
	var new_tardigrade_scene := preload("res://creatures/tardigrade/tardigrade.tscn")
	var new_tardigrade = new_tardigrade_scene.instantiate()
	
	# spawn portal
	var new_portal_scene := preload("res://screens/shared/portal.tscn")
	var new_portal = new_portal_scene.instantiate()
	new_portal.global_position = $"../CreatureSpawn".global_position
	self.add_child(new_portal)
	
	# delay then spawn tardigrade - tween in scale
	await get_tree().create_timer(1.0).timeout
	var starting_scale = new_tardigrade.scale
	new_tardigrade.scale = Vector2(0,0) # zero for tweening
	new_tardigrade.global_position = $"../CreatureSpawn".global_position
	add_child(new_tardigrade)
	#spawn_talk(new_bat)
	var tardigrade_scale_in = create_tween()
	tardigrade_scale_in.tween_property(new_tardigrade,"scale", starting_scale, 1).set_trans(Tween.TRANS_CUBIC)
	await tardigrade_scale_in.finished
	
	# pick and move to spawn
	var tardigrade_spawn_points = $"../TardigradeSpawns".get_children()
	var tardigrade_spawn_node = tardigrade_spawn_points.pick_random()
	new_tardigrade.destination_position = tardigrade_spawn_node.global_position
	new_tardigrade.moving = true
	
	# check for max tardigrades, remove first child (with puff effect)
	#var tardigrade_count = get_child_count()
	#if tardigrade_count > max_tardigrades_on_screen:
	#	destroy_first_child()
	
func start_random_timer():
	# Set a random time between 1 and 5 seconds
	tardigrade_timer.wait_time = rng.randf_range(min_rotate_time, max_rotate_time)
	tardigrade_timer.start()
	
func _on_tardigrade_timer_timeout() -> void:
	print("Timer timed out")
	start_random_timer()
	if get_child_count() > 0:
		tardigrade_swap()
	
func tardigrade_swap():
	var random_child = get_children().pick_random()
	if random_child is Tardigrade:
		print("we got a tarigrade here")
		var tardigrade_spawn_points = $"../TardigradeSpawns".get_children()
		var tardigrade_spawn_node = tardigrade_spawn_points.pick_random()
		if !random_child.moving:
			random_child.destination_position = tardigrade_spawn_node.global_position
			random_child.moving = true
	
