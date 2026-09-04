class_name GameController extends Node2D

# Game controller:
# Handles all global scene transitions

@export var world_2d : Node2D
@export var gui : Node

var current_2d_scene
var current_gui_scene

var bat_dir : String = "exports/bats"
var tardigrade_dir : String = "exports/tardigrades"
var salamander_dir : String = "exports/salamanders"
var bigguy_dir : String = "exports/bigguys"

func _init() -> void:
	Global.game_controller = self

func _ready() -> void:
	if Global.is_first_run:
		# Do file cleanup on launch
		file_cleanup()
		Global.is_first_run = false
		
	# Load splash screen
	Global.game_controller.change_2d_scene("res://screens/drawing_screen/1_splash_screen/splash_screen_manager.tscn")

func change_gui_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
		if current_gui_scene != null:
			if delete:
				current_gui_scene.queue_free() # Removes node entirely
			elif keep_running:
				current_gui_scene.visible = false # Keeps in memory and running
			else:
				gui.remove_child(current_gui_scene) # Keeps in memory, does not run
		var new = load(new_scene).instantiate()
		gui.add_child(new)
		current_gui_scene = new
		
# Add clear_gui_scene which just does delete, keep_running, and remove without setting a new scene
func clear_gui_scene() -> void:
	if current_gui_scene != null:
		current_gui_scene.queue_free()

func change_2d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
		if current_2d_scene != null:
			if delete:
				current_2d_scene.queue_free() # Removes node entirely
			elif keep_running:
				current_2d_scene.visible = false # Keeps in memory and running
			else:
				world_2d.remove_child(current_2d_scene) # Keeps in memory, does not run
		var new = load(new_scene).instantiate()
		world_2d.add_child(new)
		current_2d_scene = new
		
func file_cleanup() -> void:
	# make sure export directories exist
	var dir = DirAccess.open("user://")
	dir.make_dir_recursive(bat_dir)
	dir.make_dir_recursive(tardigrade_dir)
	dir.make_dir_recursive(salamander_dir)
	dir.make_dir_recursive(bigguy_dir)
	
	# remove any files
	dir = DirAccess.open("user://" + bat_dir)
	for file in dir.get_files():
		dir.remove(file)
	
	dir = DirAccess.open("user://" + tardigrade_dir)
	for file in dir.get_files():
		dir.remove(file)
	
	dir = DirAccess.open("user://" + salamander_dir)
	for file in dir.get_files():
		dir.remove(file)
	
	dir = DirAccess.open("user://" + bigguy_dir)
	for file in dir.get_files():
		dir.remove(file)
	pass
