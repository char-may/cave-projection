class_name Paintbrush extends DrawingToolButton

@export var outlines : Sprite2D
@export var brush : Sprite2D
@export var paint : Sprite2D
	
func _process(_delta: float) -> void:
	super(_delta)

	if !active:
		outlines.visible = true
		brush.visible = false
		paint.visible = false
	else:
		outlines.visible = false
		brush.visible = true
		paint.modulate = Global.active_color
		paint.visible = true
