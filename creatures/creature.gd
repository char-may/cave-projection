class_name Creature extends Node2D

@onready var polygons = $Container/Polygons
@onready var destination_position = $DestinationPosition.global_position

@export var creature_type : Global.CreatureType = Global.CreatureType.BAT
@export var move_speed : float = 200.0
@export var moving : bool = false

# constructor
func _init():
	pass
	
func _ready():
	set_texture(Global.finished_atlus)

func _process(delta: float) -> void:
	# handle movement
	go_there(delta)
	
# set texture of all polygons
func set_texture(texture: ImageTexture) -> void:
	if polygons && texture:
		for p in polygons.get_children():
			if p is Polygon2D:
				p.texture = texture

func go_there(delta) -> void:
	if moving:
		global_position = global_position.move_toward(destination_position, delta * move_speed)
	if global_position == destination_position:
		moving = false
