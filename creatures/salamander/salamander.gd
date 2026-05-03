class_name Salamander extends Creature

@onready var anim = $AnimationPlayer
@onready var body = $Container/Polygons/Body
var transitioning : bool = false

func _ready():
	super()
	if body:
		for part in body.get_children():
			if part is Polygon2D:
				part.texture = Global.finished_atlus

func reload_texture() -> void:
	if body:
		body.texture = Global.finished_atlus
		for part in body.get_children():
			if part is Polygon2D:
				part.texture = Global.finished_atlus
