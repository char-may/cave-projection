class_name ColorSwatchSelector extends GridContainer

# Color swatch selector:
# A grid container that shows and hides a palette of 
# color buttons when the pen tool button is pressed

# Signals:
# Recieve -> Color button pressed, Pen button pressed
# Emit -> Swatch color selected

#signal color_selected(color:Color)
var out : bool = false # TODO: rename this

# TODO: Create swatches dynamically based on palette resource size

func _ready() -> void:
	for child in get_children():
		if child is ColorButton:
			child.hide() # Hide palette until tool is pressed
			
			# Connect the pressed signal to our function
			# Bind the ColorButton to it so we can access the color
			child.pressed.connect(_on_color_button_pressed.bind(child))

func _process(delta: float) -> void:
	if !get_parent().active:
		collapse_palette()
	
func _on_color_button_pressed(button:ColorButton) -> void:
	if get_parent().active:
		GlobalSignal.swatch_color_selected.emit(button.color)
		collapse_palette()

func on_drawing_tool_selected(_size) -> void:
	if get_parent().active && out:
		collapse_palette()
	else:
		if get_parent().type == Global.selected_tool:
			await get_tree().create_timer(.05).timeout
			expand_palette()
	
func expand_palette() -> void:
	out = true
	for child in get_children():
		if child is ColorButton:
			await get_tree().create_timer(.01).timeout
			child.show()

func collapse_palette() -> void:
	out = false
	for child in get_children():
		if child is ColorButton:
			child.hide()

func _on_tree_entered() -> void:
	GlobalSignal.drawing_tool_selected.connect(on_drawing_tool_selected)


func _on_tree_exited() -> void:
	GlobalSignal.drawing_tool_selected.disconnect(on_drawing_tool_selected)
