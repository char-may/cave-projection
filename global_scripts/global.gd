extends Node

enum CreatureType {
	BAT,
	TARDIGRADE,
	SALAMANDER,
	BIGGUY
}

enum ToolType {
	CRAYON,
	BRUSH,
	ERASER
}

var game_controller : GameController
var is_first_run = true # used in game controller to see if reset or first run, for file cleanup

# preload scene to memory at compile time
const PUFF = preload("res://screens/cave_screen/puff.tscn") # puff effect

# Editor stuff
var creature_editing : CreatureType = CreatureType.BAT
var finished_atlus : ImageTexture = null
var selected_tool : ToolType = ToolType.CRAYON
var active_color : Color
var tool_size : int
var background_color : Color = "2f589e"

func get_drawing_color() -> Color:
	if selected_tool == ToolType.ERASER:
		return background_color
	else:
		return active_color
		
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
		"salamander":
			dir.make_dir("exports/salamanders")
			dir = DirAccess.open("user://exports/salamanders/")
		"bigguy":
			dir.make_dir("exports/bigguys")
			dir = DirAccess.open("user://exports/bigguys/")
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
			
	finished_atlus = ImageTexture.create_from_image(image)
