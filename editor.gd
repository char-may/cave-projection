class_name Editor extends Node2D

var exportCount = 0

func _ready():
	
	# Create export directory
	var dir = DirAccess.open("user://")
	dir.make_dir("exports")
	dir = DirAccess.open("user://exports")
	
	# Set counter to the current number of files
	for n in dir.get_files():
		exportCount += 1

	# Output to test
	print ("Number of files in exports folder: %d" % exportCount)
	
func _input(event):
	# TODO Change this action to something like "export" when UI is finished
	if event.is_action_pressed("screenshot"):
		screenshot()
	
func screenshot():
	print ("Camera sound!") # Confirm action
	
	await RenderingServer.frame_post_draw
	
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	img.save_png("user://exports/export"+str(exportCount)+".png")
	exportCount += 1
	
	## Creature new creature
	#var newCreature = Creature.new()
	#newCreature.type = currently_editing.type
	#newCreature.drawing_mask = currently_editing.drawing_mask
	#newCreature.palette = currently_editing.palette
	#newCreature.texture = currently_editing.texture #change this
	#newCreature.secret = "I'm the copy, yay!"
