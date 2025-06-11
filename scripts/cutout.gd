extends Node2D

@export var polygons : Node2D
@export var atlus : CompressedTexture2D

# Set texture of all polygons in the scene to the assigned atlus
func _ready():	
	if polygons:
		for p in polygons.get_children():
			if p is Polygon2D:
				p.texture = atlus
