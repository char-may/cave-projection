class_name Editor extends Node2D

# Editor:
# Exports drawings, loads scene ui and handles transitions

@export var mask : Control
@export var confirm_scene : PackedScene
var background
var export_count = 0

# TODO: Set template/mask based on currently editing creature
# just store all 4 masks as editor properties

func _ready():
	# Add editor UI to game
	Global.game_controller.change_gui_scene("res://scenes/editor_ui.tscn", true, false)
	
	background = get_node("Background")
	
	# Create export directory
	var dir = DirAccess.open("user://")
	dir.make_dir("exports")
	dir = DirAccess.open("user://exports")
	# Set counter to the current number of files
	for n in dir.get_files():
		export_count += 1

	print ("Number of files already in exports folder: %d" % export_count)
	
# todo : why am i doing this?
#func _process(_delta: float) -> void:
	#background.color = Global.background_color
	
	
func _input(event):
	# TODO Change this action to something like "export" when UI is finished
	if event.is_action_pressed("screenshot"):
		screenshot()
	
func screenshot():
	await RenderingServer.frame_post_draw
	export_count += 1
	
	# Save image to the user directory
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	var path = "user://exports/export"+str(export_count)+".png"
	img.save_png(path)
	
	# Save image texture to global
	var image = Image.new()
	var load_err := image.load(path)
	assert(load_err == OK, "Failed to load image at: ")
	Global.finished_atlus = ImageTexture.create_from_image(image)
	
	Global.game_controller.change_2d_scene("res://scenes/polygon_bat.tscn", true, false)
	Global.game_controller.change_gui_scene("res://scenes/empty_gui.tscn", true, false)

func on_set_background_color(color) -> void:
	background = get_node("Background")
	background.color = color
