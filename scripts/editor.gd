class_name Editor extends Node2D

@export var ui : Control

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
	print ("Camera sound!") # Confirm action

	if ui:
		ui.visible = false
		
	await RenderingServer.frame_post_draw
	
	# Make sure stretch mode is set to viewport
	# and aspect is set to keep in project settings
	# this keeps the viewport img captured a consistent size
	# and doesn't seem to behave any differently when resized
	
	# I fudged the numbers of this rect until it captured the
	# 1024, 1024 rect containing the part that will be used
	# as the creature UV as close as possible
	# would be better if these numbers made sense... 
	
	var rect := Rect2i(450,26,1024,1024)
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image().get_region(rect)
	
	# look at Image.blit_rect_mask to mask image
	# still trying to find a good example of how this works

	img.save_png("user://exports/export"+str(export_count)+".png")
	export_count += 1
	
	# Show ui
	if ui:
		ui.visible = true
