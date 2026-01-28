extends Node2D

@export var bat_scene : PackedScene

func _ready() -> void:
	GlobalSignal.new_bat_created.connect(on_bat_created)

func on_bat_created():
	var new_bat = bat_scene.instantiate()
	self.add_child(new_bat)
