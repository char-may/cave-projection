extends Node2D

@export var bat_scene : PackedScene
@export var tardigrade_scene : PackedScene

func _ready() -> void:
	GlobalSignal.new_bat_created.connect(create_bat)
	GlobalSignal.new_tardigrade_created.connect(create_tardigrade)

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("create_bat")):
		select_random_texture("bat")
		create_bat()
	if (Input.is_action_just_pressed("create_tardigrade")):
		select_random_texture("tardigrade")
		create_tardigrade()

func create_bat():
	var new_bat_scene := preload("res://creatures/bat/bat.tscn")
	var new_bat = new_bat_scene.instantiate()
	# Pick spawn
	var bat_spawn_points = $BatSpawns.get_children()
	var bat_spawn_node = bat_spawn_points.pick_random()
	self.add_child(new_bat)
	new_bat.destination_position = bat_spawn_node.global_position
	new_bat.moving = true

func create_tardigrade():
	var new_tardigrade_scene := preload("res://creatures/tardigrade/tardigrade.tscn")
	var new_tardigrade = new_tardigrade_scene.instantiate()
	# Pick spawn
	var tardigrade_spawn_points = $TardigradeSpawns.get_children()
	var tardigrade_spawn_node = tardigrade_spawn_points.pick_random()
	self.add_child(new_tardigrade)
	new_tardigrade.destination_position = tardigrade_spawn_node.global_position
	new_tardigrade.moving = true

func select_random_texture(type: String):
	# sets Global.finished_atlas to a random file from creature directory
	# currently using input but may need to be a signal for auto-populate
	
	var creature_images: PackedStringArray = []
	var path = "user://"
	var dir = DirAccess.open(path)
	
	# get directory
	match type:
		"bat":
			dir.make_dir("exports/bats")
			dir = DirAccess.open("user://exports/bats/")
		"tardigrade":
			dir.make_dir("exports/tardigrades")
			dir = DirAccess.open("user://exports/tardigrades/")
		_: #wildcard default bat
			dir.make_dir("exports/bats")
			dir = DirAccess.open("user://exports/bats/")
			
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
		# break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with("."):
		# get_next() returns a string so this can be used to load the images into an array.
			creature_images.append(file_name)
	dir.list_dir_end()
	
	# Get random bat image
	var random_image_path: String = Array(creature_images).pick_random()
	
	# Save image texture to global
	var image = Image.new()
	match type:
		"bat":
			var load_err := image.load("user://exports/bats/" + random_image_path)
			assert(load_err == OK, "Failed to load image at: ")
		"tardigrade":
			var load_err := image.load("user://exports/tardigrades/" + random_image_path)
			assert(load_err == OK, "Failed to load image at: ")
		_:
			var load_err := image.load("user://exports/bats/" + random_image_path)
			assert(load_err == OK, "Failed to load image at: ")
			
	Global.finished_atlus = ImageTexture.create_from_image(image)
