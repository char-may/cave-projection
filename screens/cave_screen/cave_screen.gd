extends Node2D

@export var bat_scene : PackedScene
@export var tardigrade_scene : PackedScene


func _ready() -> void:
	GlobalSignal.new_bat_created.connect(on_bat_created)
	GlobalSignal.new_tardigrade_created.connect(on_tardigrade_created)


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("make_bat")):
		create_random_bat()
	if (Input.is_action_just_pressed("make_tardigrade")):
		create_random_tardigrade()

func on_bat_created():
	var new_bat = bat_scene.instantiate()
	self.add_child(new_bat)
	
func on_tardigrade_created():
	var new_tardigrade = tardigrade_scene.instantiate()
	self.add_child(new_tardigrade)
	
# For prototyping only
func create_random_bat():
	#Get bat images
	var bat_images: PackedStringArray = []
	var path = "user://"
	var dir = DirAccess.open(path)
	dir.make_dir("exports/bats")
	dir = DirAccess.open("user://exports/bats/")
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
		#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with("."):
		#get_next() returns a string so this can be used to load the images into an array.
			bat_images.append(file_name)
	dir.list_dir_end()
	
	# Get random bat image
	var random_bat_path: String = Array(bat_images).pick_random()
	
	# Save image texture to global
	var image = Image.new()
	var load_err := image.load("user://exports/bats/" + random_bat_path)
	assert(load_err == OK, "Failed to load image at: ")
	Global.finished_atlus = ImageTexture.create_from_image(image)
	
	# Create bat
	var new_bat_scene := preload("res://creatures/bat/bat.tscn")
	var new_bat = new_bat_scene.instantiate()
	# Pick spawn
	var bat_spawn_points = $BatSpawns.get_children()
	var bat_spawn_node = bat_spawn_points.pick_random()
	self.add_child(new_bat)
	print(new_bat.destination_position)
	new_bat.destination_position = bat_spawn_node.global_position
	print(new_bat.destination_position)
	print(bat_spawn_node.position)
	new_bat.moving = true
	print(new_bat.moving)




func create_random_tardigrade():
	#Get tardigrade images
	var tardigrade_images: PackedStringArray = []
	var path = "user://"
	var dir = DirAccess.open(path)
	dir.make_dir("exports/tardigrades")
	dir = DirAccess.open("user://exports/tardigrades/")
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
		#break the while loop when get_next() returns ""
			break
		elif !file_name.begins_with("."):
		#get_next() returns a string so this can be used to load the images into an array.
			tardigrade_images.append(file_name)
	dir.list_dir_end()
	
	# Get random bat image
	var random_tardigrade_path: String = Array(tardigrade_images).pick_random()
	
	# Save image texture to global
	var image = Image.new()
	var load_err := image.load("user://exports/tardigrades/" + random_tardigrade_path)
	assert(load_err == OK, "Failed to load image at: ")
	Global.finished_atlus = ImageTexture.create_from_image(image)
	
	# Create tardigrade
	var new_tardigrade_scene := preload("res://creatures/tardigrade/tardigrade.tscn")
	var new_tardigrade = new_tardigrade_scene.instantiate()
	# Pick spawn
	var tardigrade_spawn_points = $TardigradeSpawns.get_children()
	var tardigrade_spawn_node = tardigrade_spawn_points.pick_random()
	new_tardigrade.global_position = tardigrade_spawn_node.position
	print(new_tardigrade.scale)
	self.add_child(new_tardigrade)
	
