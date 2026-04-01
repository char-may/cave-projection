class_name Creature extends Node2D

@onready var polygons = $Container/Polygons
@onready var destination_position = $DestinationPosition.global_position

var creature_type : Global.CreatureType = Global.CreatureType.BAT
const move_speed : float = 25
var moving : bool = false

# constructor
func _init():
	pass
	
func _ready():
	set_texture(Global.finished_atlus)

func _process(_delta: float) -> void:
	# handle movement
	go_there()
	
# set texture of all polygons
func set_texture(texture: ImageTexture) -> void:
	if polygons && texture:
		for p in polygons.get_children():
			if p is Polygon2D:
				p.texture = texture

func go_there() -> void:
	if moving:
		var tween = create_tween()
		tween.tween_property(self, "global_position", destination_position, move_speed).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		moving = false
