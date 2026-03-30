extends Node

func _ready() -> void:
	GlobalSignal.new_tardigrade_created.connect(create_tardigrade)

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("create_tardigrade")):
		Global.select_random_texture("tardigrade")
		create_tardigrade()

func create_tardigrade():
	var new_tardigrade_scene := preload("res://creatures/tardigrade/tardigrade.tscn")
	var new_tardigrade = new_tardigrade_scene.instantiate()
	# Pick spawn
	var tardigrade_spawn_points = $"../TardigradeSpawns".get_children()
	var tardigrade_spawn_node = tardigrade_spawn_points.pick_random()
	self.add_child(new_tardigrade)
	new_tardigrade.destination_position = tardigrade_spawn_node.global_position
	new_tardigrade.moving = true
