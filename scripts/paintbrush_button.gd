class_name Paintbrush extends DrawingToolButton

@export var paint : Sprite2D
@export var handle : Sprite2D
@export var bristles : Sprite2D
@export var ferrule : Sprite2D

@export var handle_color : Color
@export var bristles_color : Color
@export var ferrule_color : Color

func _process(_delta: float) -> void:
	super(_delta)

# default colors:
# handle: 8f614b
# bristles: 515151
# ferrule: b9b6b5
#
#
	if !active:
		paint.visible = false
		handle.modulate = Color.WHITE
		bristles.modulate = Color.WHITE
		ferrule.modulate = Color.WHITE
	else:
		if active_color == inactive_color:
			paint.visible = false
		else:
			paint.modulate = active_color
			handle.modulate = handle_color
			bristles.modulate = bristles_color
			ferrule.modulate = ferrule_color
			paint.visible = true
