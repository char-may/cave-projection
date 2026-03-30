extends Node

const max_bats : int = 3

func _ready() -> void:
	GlobalSignal.new_bat_created.connect(create_bat)
	
func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("create_bat")):
		Global.select_random_texture("bat")
		create_bat()
	
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
	var bat_scale_in = create_tween()
	bat_scale_in.tween_property(new_bat,"scale", starting_scale, 1).set_trans(Tween.TRANS_CUBIC)
	await bat_scale_in.finished
	
	# pick and move to spawn
	var bat_spawn_points = $"../BatSpawns".get_children()
	var bat_spawn_node = bat_spawn_points.pick_random()
	new_bat.destination_position = bat_spawn_node.global_position
	new_bat.moving = true
	
	# check for max bats
	var bat_count = get_child_count()
	if bat_count > max_bats:
		print("We have too many bats, sending oldest away!")
		var first_child = get_child(0)
		first_child.queue_free() # *** make an actual transition (fly off screen first)
