class_name Editor extends Node2D

@export var ui : Control
@export var mask : Control
@export var confirm_scene : PackedScene

var export_count = 0

# TODO: Set template/mask based on currently editing creature
# just store all 4 masks as editor properties

func _ready():
	
	# Create export directory
	var dir = DirAccess.open("user://")
	dir.make_dir("exports")
	dir = DirAccess.open("user://exports")
	
	# Set counter to the current number of files
	for n in dir.get_files():
		export_count += 1

	# TODO: print currently editing/other game state here
	# Output to test
	print ("Number of files already in exports folder: %d" % export_count)
	
	
func _input(event):
	# TODO Change this action to something like "export" when UI is finished
	if event.is_action_pressed("screenshot"):
		screenshot()
	
func screenshot():
	hide_ui()
	await RenderingServer.frame_post_draw
	
	export_count += 1
	
	# Save image to the user directory
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	var path = "user://exports/export"+str(export_count)+".png"
	img.save_png(path)
	
	# Save image texture to global                     <-- work on this
	var image = Image.new()
	var load_err := image.load(path)
	assert(load_err == OK, "Failed to load image at: ")
	#Global.atlas_texture = ImageTexture.create_from_image(image)
	
	show_ui()
#	get_tree().change_scene(confirm_scene)

func hide_ui():
	if ui:
		ui.visible = false
	
	if mask:
		mask.visible = false

func show_ui():
	if ui:
		ui.visible = true
	
	if mask:
		mask.visible = true
