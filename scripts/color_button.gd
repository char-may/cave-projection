#@tool
class_name ColorButton extends Button

# Color button:
# Draws a flat rectangle button with customizable color.

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
	
	#TODO: add check for type drawing tool button and make it rectangle
	# while default color buttons are round
	# or make seperate class for drawing tool button that doesn't extend color button
	# to do custom graphic etc.
