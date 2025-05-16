class_name Editor extends Node2D

var ssCount = 1  #screenshot count

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
	await RenderingServer.frame_post_draw
	
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	img.save_png("user://screenshots/ss"+str(ssCount)+".png")
	ssCount += 1
	
	# Assuming you have a resource named 'my_resource'
var duplicated_resource = Global.currently_editing.duplicate()

# Save the duplicated resource
var save_path = "user://my_saved_resource.tres"  # Change this to your desired path
ResourceSaver.save(duplicated_resource, save_path)
