class_name EraserButton extends DrawingToolButton

@export var sleeve : Sprite2D
@export var tip : Sprite2D

@export var sleeve_color : Color
@export var tip_color : Color
	
func _process(_delta: float) -> void:
	super(_delta)
	if !active:
		sleeve.modulate = Global.environment_color
		tip.modulate = Global.environment_color
	else:
		sleeve.modulate = sleeve_color
		tip.modulate = tip_color
