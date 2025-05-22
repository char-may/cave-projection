class_name Editor extends Node2D

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
	
	await RenderingServer.frame_post_draw
	
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	img.save_png("user://exports/export"+str(export_count)+".png")
	export_count += 1
	
	## Creature new creature
	#var new_creature = Creature.new()
	#new_creature.type = currently_editing.type
	#new_creature.drawing_mask = currently_editing.drawing_mask
	#new_creature.palette = currently_editing.palette
	#new_creature.texture = currently_editing.texture #change this
	#new_creature.secret = "I'm the copy, yay!"
