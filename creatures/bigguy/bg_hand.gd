class_name BigGuyHands extends Node2D

func _ready() -> void:
	for child in get_children():
		if child is Polygon2D:
			child.texture = Global.finished_atlus
