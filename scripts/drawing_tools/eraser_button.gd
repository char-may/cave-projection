class_name EraserButton extends DrawingToolButton

@export var body : Sprite2D
@export var ring : Sprite2D
@export var tip : Sprite2D

@export var body_color : Color
@export var ring_color : Color
@export var tip_color : Color
	
func _process(_delta: float) -> void:
	super(_delta)
	if !active:
		body.modulate = Global.environment_color
		ring.modulate = Global.environment_color
		tip.modulate = Global.environment_color
	else:
		Global.active_color = Global.background_color
		body.modulate = body_color
		ring.modulate = ring_color
		tip.modulate = tip_color
