class_name Crayon extends DrawingToolButton

@export var outlines : Sprite2D
@export var body_bg : Sprite2D
@export var body : Sprite2D
@export var band : Sprite2D
@export var tip : Sprite2D

func _ready() -> void:
	super()
	body_bg.modulate = Color.WHITE
	
func _process(_delta: float) -> void:
	super(_delta)
	if !active:
		outlines.visible = true
		band.visible = false
		body_bg.visible = false
		body.visible = false
		tip.visible = false
	else:
		outlines.visible = false
		band.visible = true
		body_bg.modulate = Color.WHITE
		body_bg.visible = true
		tip.modulate = Global.active_color
		var body_color = Color(Global.active_color, .5)
		body.modulate = body_color
		body.visible = true
		tip.visible = true
