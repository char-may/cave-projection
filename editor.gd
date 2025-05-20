class_name Editor extends Node2D

var exports = 0

func _ready():
	
	# Check
	var dir = load("res://Resources/Creatures/Exported")
	for n in dir.get_files():
		exports += 1

	print ("Number of files: " + exports)
	
func _input(event):
	if event.is_action_pressed("screenshot"):
		screenshot()
	
func screenshot():
	print ("Camera sound")
	
	## Creature new creature
	#var newCreature = Creature.new()
	#newCreature.type = currently_editing.type
	#newCreature.drawing_mask = currently_editing.drawing_mask
	#newCreature.palette = currently_editing.palette
	#newCreature.texture = currently_editing.texture #change this
	#newCreature.secret = "I'm the copy, yay!"
#
	#await RenderingServer.frame_post_draw
	#
	#var viewport = get_viewport()
	#var img = viewport.get_texture().get_image()
	#img.save_png("user://screenshots/ss"+str(ssCount)+".png")
	#ssCount += 1
	#
	## Duplicate resource
	#var duplicated_resource = currently_editing.duplicate(true)
	#
	## Save the duplicated resource
	#var save_path = "res://resources/creatures/exports/saved_bat.tres"
	#ResourceSaver.save(newCreature, save_path)
