class_name Editor extends Node2D

var ssCount = 1  #screenshot count

@export var currently_editing : Creature

func _ready():
	
	# create screenshot directory
	var dir = DirAccess.open("user://")
	dir.make_dir("screenshots")
	dir = DirAccess.open("user://screenshots")
	for n in dir.get_files():
		ssCount += 1

func _input(event):
	if event.is_action_pressed("screenshot"):
		screenshot()
	
func screenshot():
	#await RenderingServer.frame_post_draw
	#
	#var viewport = get_viewport()
	#var img = viewport.get_texture().get_image()
	#img.save_png("user://screenshots/ss"+str(ssCount)+".png")
	#ssCount += 1
	
	# Duplicate resource
	var duplicated_resource : Creature = currently_editing.duplicate(true)
	#duplicated_resource.palette = currently_editing.palette # not duplicated without this line?
	# Save the duplicated resource
	#var save_path = "res://resources/exports/saved_bat_%s.tres" % duplicated_resource.get_rid()

	print (typeof(duplicated_resource.get_rid())) 
	#ResourceSaver.save(duplicated_resource, save_path)
