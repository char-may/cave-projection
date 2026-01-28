extends Node2D

@export var bat_scene : PackedScene
@export var tardigrade_scene : PackedScene

func _ready() -> void:
	GlobalSignal.new_bat_created.connect(on_bat_created)
	GlobalSignal.new_tardigrade_created.connect(on_tardigrade_created)

func on_bat_created():
	var new_bat = bat_scene.instantiate()
	self.add_child(new_bat)
	
func on_tardigrade_created():
	var new_tardigrade = tardigrade_scene.instantiate()
	self.add_child(new_tardigrade)
