class_name ColorButton extends Button

# Color button:
# Draws a flat circular button with customizable color.

var circle_radius : float = 20

@export var color:Color = Color.WHITE:
	set(value):
		# Change the color to the new value and redraw
		color = value
		queue_redraw()
		
func _ready() -> void:
	flat = true
	custom_minimum_size = Vector2(circle_radius * 2, circle_radius * 2)

func _draw() -> void:
	# Draw a cirle with the color
	draw_circle(Vector2.ZERO + Vector2(circle_radius, circle_radius), circle_radius, color, true)
