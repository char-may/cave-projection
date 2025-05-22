class_name SwatchSelector extends GridContainer

signal color_selected(color:Color)
var out : bool = false # TODO: rename this

# TODO: Set # of columns based on size of palette
# set color of each swatch from palette

func _ready() -> void:
	for child in get_children():
		if child is SwatchButton:
			child.hide() # Hide palette until tool is pressed
			
			# Connect the pressed signal to our function
			# Bind the ColorButton to it so we can access the color.
			child.pressed.connect(_on_color_button_pressed.bind(child))

func _on_color_button_pressed(button:SwatchButton) -> void:
	# Emit the color_selected signal with the color of the ColorButton
	color_selected.emit(button.color)
	collapse_palette()

func _on_pen_button_pressed() -> void:
	if out:
		collapse_palette()
	else:
		await get_tree().create_timer(.05).timeout
		expand_palette()
	
func expand_palette() -> void:
	out = true
	for child in get_children():
		if child is SwatchButton:
			await get_tree().create_timer(.01).timeout
			child.show()

func collapse_palette() -> void:
	out = false
	for child in get_children():
		if child is SwatchButton:
			child.hide()
