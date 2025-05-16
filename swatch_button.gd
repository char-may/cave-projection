@tool
class_name SwatchButton extends Button

@export var color:Color = Color.WHITE:
	set(value):
		# Change the color to the new value and redraw
		color = value
		queue_redraw()
		
func _ready() -> void:
	flat = true

func _draw() -> void:
	# Draw a rectangle with the color
	draw_rect(Rect2(Vector2.ZERO, size), color)
