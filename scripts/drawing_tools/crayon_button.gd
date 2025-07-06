class_name Crayon extends DrawingToolButton

@export var body_bg : Sprite2D
@export var body : Sprite2D
@export var tip : Sprite2D

func _ready() -> void:
	super()
	body_bg.modulate = Color.WHITE
	
func _process(_delta: float) -> void:
	super(_delta)
	if !active:
		tip.modulate = Global.environment_color
		body_bg.modulate = Global.environment_color
		body.visible = false
	else:
		body_bg.modulate = Color.WHITE
		tip.modulate = Global.active_color
		var body_color = Color(Global.active_color, .5)
		body.modulate = body_color
		body.visible = true
