class_name Creature extends Node2D

@onready var center_point = $CenterPoint
@onready var polygons = $CenterPoint/Polygons

# constructor
func _init():
	pass
	
func _ready():
	set_texture(Global.finished_atlus)

# set texture of all polygons
func set_texture(texture: ImageTexture) -> void:
	if polygons && texture:
		for p in polygons.get_children():
			if p is Polygon2D:
				p.texture = texture
