class_name EraserButton extends DrawingToolButton

@export var outlines : Sprite2D
@export var filled : Sprite2D
	
func _process(_delta: float) -> void:
	super(_delta)
	if !active:
		outlines.visible = true
		filled.visible = false
	else:
		outlines.visible = false
		filled.visible = true
