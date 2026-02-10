class_name GameController extends Node2D

# Game controller:
# Handles all global scene transitions

@export var world_2d : Node2D
@export var gui : Node

var current_2d_scene
var current_gui_scene

func _init() -> void:
	Global.game_controller = self

func _ready() -> void:
	#Add exports for default 2d and gui scene to load
	
	Global.game_controller.change_gui_scene("res://screens/drawing_screen/1_splash_screen/splash_screen_manager.tscn")

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
