extends Node

const max_bats_on_screen : int = 6
var rng

var min_rotate_time: float = 15.0
var max_rotate_time: float = 35.0

@onready var bat_timer : Timer = $"../BatTimer"

func _ready() -> void:
	GlobalSignal.new_bat_created.connect(create_bat)
	rng = RandomNumberGenerator.new()
	rng.randomize()
	start_random_timer()
	
func start_random_timer():
	# Set a random time between 1 and 5 seconds
	bat_timer.wait_time = rng.randf_range(min_rotate_time, max_rotate_time)
	bat_timer.start()
	
func create_bat():
	var new_bat_scene := preload("res://creatures/bat/bat.tscn")
	var new_bat = new_bat_scene.instantiate()
	
	# spawn portal
	var new_portal_scene := preload("res://screens/shared/portal.tscn")
	var new_portal = new_portal_scene.instantiate()
	new_portal.global_position = $"../CreatureSpawn".global_position
	self.add_child(new_portal)
	
	# delay then spawn bat - tween in scale
	await get_tree().create_timer(1.0).timeout
	var starting_scale = new_bat.scale
	new_bat.scale = Vector2(0,0) # zero for tweening
	new_bat.global_position = $"../CreatureSpawn".global_position
	add_child(new_bat)
	spawn_talk(new_bat)
	var bat_scale_in = create_tween()
	bat_scale_in.tween_property(new_bat,"scale", starting_scale, 1).set_trans(Tween.TRANS_CUBIC)
	await bat_scale_in.finished
	
	# pick and move to spawn
	var bat_spawn_points = $"../BatSpawns".get_children()
	var bat_spawn_node = bat_spawn_points.pick_random()
	new_bat.destination_position = bat_spawn_node.global_position
	new_bat.moving = true
	
	# check for max bats, remove first child (with puff effect)
	var bat_count = get_child_count()
	if bat_count > max_bats_on_screen:
		destroy_first_child()
	
func destroy_first_child() -> void:
	# check if children exist
	if get_child_count() > 0:
		var first_child = get_child(0)
		# do puff and destroy child
		var puff_instance = Global.PUFF.instantiate()
		if first_child.has_node("Container"):
			puff_instance.position = first_child.get_node("Container").global_position
			add_child(puff_instance)
			GlobalSignal.do_puff.emit()
			first_child.queue_free()
			await get_tree().create_timer(3.0).timeout
			puff_instance.queue_free()
		
func _on_bat_timer_timeout() -> void:
	start_random_timer()
	if get_child_count() > 0:
		bat_swap()
	
func bat_swap() -> void: # move random bat to random spawn point
	var random_child = get_children().pick_random()
	if random_child is Bat:
		var bat_spawn_points = $"../BatSpawns".get_children()
		var bat_spawn_node = bat_spawn_points.pick_random()
		if !random_child.moving:
			random_child.destination_position = bat_spawn_node.global_position
			random_child.moving = true
	
func spawn_talk(target) -> void:
	# Say "?" when spawning
	target.talking = true
	target.label.text = "?"
	target.label.visible = true
	await get_tree().create_timer(2.0).timeout
	target.label.visible = false
	target.talking = false
