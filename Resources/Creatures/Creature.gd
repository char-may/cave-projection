class_name Creature
extends Resource

# id?
# mesh
# animation stuff

enum TYPE {BAT, TARDIGRADE}
@export var type : TYPE
@export var palette : Palette
@export var drawing_mask : CompressedTexture2D
@export var texture : CompressedTexture2D

func _init() -> void:
	pass
