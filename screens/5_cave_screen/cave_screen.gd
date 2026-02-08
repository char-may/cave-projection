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
	var new_bat_scene := preload("res://screens/4_finished_screen/animated_bat.tscn")
	var new_bat = new_bat_scene.instantiate()
	
	# set random spawn point
	var bat_center = new_bat.get_node("CenterPoint")
	var spawn_node_position: Vector2 = get_spawn_node_pos()
	bat_center.global_position = spawn_node_position
	
	#var random_scale = randf_range(0.1, 0.25)
	#bat_center.scale = Vector2(random_scale, random_scale)
	self.add_child(new_bat)


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
	var new_tardigrade_scene := preload("res://screens/4_finished_screen/animated_tardigrade.tscn")
	var new_tardigrade = new_tardigrade_scene.instantiate()
	var random_scale = randf_range(0.3, 1.0)
	new_tardigrade.scale = Vector2(random_scale, random_scale)
	new_tardigrade.position = Vector2(randf_range(0, 50), randf_range(0, 50))
	self.add_child(new_tardigrade)
	
func get_spawn_node_pos() -> Vector2:
	var spawn_points = $BatSpawns.get_children()
	var spawn_node = spawn_points.pick_random()
	return spawn_node.global_position
