extends Node2D

@onready var bats_container = $BatsContainer

const max_bats : int = 3

func _ready() -> void:
	GlobalSignal.new_bat_created.connect(create_bat)
	GlobalSignal.new_tardigrade_created.connect(create_tardigrade)

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("create_bat")):
		Global.select_random_texture("bat")
		create_bat()
	if (Input.is_action_just_pressed("create_tardigrade")):
		Global.select_random_texture("tardigrade")
		create_tardigrade()

func create_bat():
	var new_bat_scene := preload("res://creatures/bat/bat.tscn")
	var new_bat = new_bat_scene.instantiate()
	
	# spawn nebula
	var new_nebula_scene := preload("res://screens/shared/nebula.tscn")
	var new_nebula = new_nebula_scene.instantiate()
	new_nebula.global_position = $CreatureSpawn.global_position
	self.add_child(new_nebula)
	
	# delay then spawn bat - tween in scale
	await get_tree().create_timer(1.0).timeout
	var starting_scale = new_bat.scale
	new_bat.scale = Vector2(0,0) # zero for tweening
	new_bat.global_position = $CreatureSpawn.global_position
	bats_container.add_child(new_bat)
	var bat_scale_in = create_tween()
	bat_scale_in.tween_property(new_bat,"scale", starting_scale, 1).set_trans(Tween.TRANS_CUBIC)
	await bat_scale_in.finished
	
	# pick and move to spawn
	var bat_spawn_points = $BatSpawns.get_children()
	var bat_spawn_node = bat_spawn_points.pick_random()
	new_bat.destination_position = bat_spawn_node.global_position
	new_bat.moving = true
	
	# check for max bats
	var bat_count = bats_container.get_child_count()
	if bat_count > max_bats:
		print("We have too many bats, sending oldest away!")
		var first_child = bats_container.get_child(0)
		first_child.queue_free() # *** make an actual transition (fly off screen first)

func create_tardigrade():
	var new_tardigrade_scene := preload("res://creatures/tardigrade/tardigrade.tscn")
	var new_tardigrade = new_tardigrade_scene.instantiate()
	# Pick spawn
	var tardigrade_spawn_points = $TardigradeSpawns.get_children()
	var tardigrade_spawn_node = tardigrade_spawn_points.pick_random()
	self.add_child(new_tardigrade)
	new_tardigrade.destination_position = tardigrade_spawn_node.global_position
	new_tardigrade.moving = true
