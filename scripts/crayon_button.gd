class_name Crayon extends DrawingToolButton

@export var body_bg : Sprite2D
@export var body : Sprite2D
@export var tip : Sprite2D

func _ready():
	super()
	print(button_pos)
	
func _process(_delta: float) -> void:
	super(_delta)
	body_bg.modulate = Color.WHITE
	tip.modulate = active_color
	var body_color = Color(active_color, .5)
	body.modulate = body_color
