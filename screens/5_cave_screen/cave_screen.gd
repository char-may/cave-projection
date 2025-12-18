extends Node2D

@export var bat_scene : PackedScene

func _ready() -> void:
	GlobalSignal.new_bat_created.connect(on_bat_created)

func on_bat_created():
	var new_bat = bat_scene.instantiate()
	self.add_child(new_bat)
	#await get_tree().create_timer(1.0).timeout

	#var new_bat2 = bat_scene.instantiate()
	#self.add_child(new_bat2)
