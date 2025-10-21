extends Node2D

# Set atlas:
# Util to set the texture altus for 
# all polygons in the scene at once

@export var polygons : Node2D
@onready var global = Global

# Set texture of all polygons in the scene to global atlus
func _ready():	
	if polygons:
		for p in polygons.get_children():
			if p is Polygon2D:
				p.texture = global.finished_atlus
