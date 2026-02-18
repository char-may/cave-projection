extends Node

var cave_screen = preload("res://screens/cave_screen/cave_screen.tscn")

func _ready():
	get_viewport().set_embedding_subwindows(false)
	var cave = cave_screen.instantiate()
	add_child(cave)
	self.visible = true
	self.position = Vector2(0, 0)
	self.title = "Cave"
	self.size = Vector2(1920, 1080)

func _on_close_requested() -> void:
	queue_free() # Frees the window instance
