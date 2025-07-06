class_name ColorSwatchSelector extends GridContainer

# Color swatch selector:
# A grid container that shows and hides a palette of 
# color buttons when the pen tool button is pressed

@export_group("Color Palettes")
@export var bat_palette : Resource
@export var tardigrade_palette : Resource
@export var salamander_palette : Resource
@export var monster_palette : Resource

var active_palette : Palette
var expanded : bool = false

func _ready() -> void:
	set_active_palette()
	if active_palette:
		var b : Color = active_palette.background
		GlobalSignal.set_background_color.emit(b)
	
	for child in get_children():
		if child is ColorButton:
			child.hide() # Hide palette until tool is pressed
			
			# Connect the pressed signal to our function
			# Bind the ColorButton to it so we can access the color
			child.pressed.connect(_on_color_button_pressed.bind(child))

func _process(_delta: float) -> void:
	if !get_parent().active:
		collapse_palette()
	
func _on_color_button_pressed(button:ColorButton) -> void:
	if get_parent().active:
		GlobalSignal.swatch_color_selected.emit(button.color)
		collapse_palette()

func on_drawing_tool_selected() -> void:
	if get_parent().active && expanded:
		collapse_palette()
	else:
		if get_parent().type == Global.selected_tool:
			await get_tree().create_timer(.05).timeout
			expand_palette()
	
func expand_palette() -> void:
	expanded = true
	for child in get_children():
		if child is ColorButton:
			await get_tree().create_timer(.01).timeout
			child.show()

func collapse_palette() -> void:
	expanded = false
	for child in get_children():
		if child is ColorButton:
			child.hide()

func set_active_palette() -> void:
	match Global.creature_editing:
		Global.CreatureType.BAT:
			active_palette = bat_palette
		Global.CreatureType.TARDIGRADE:
			active_palette = tardigrade_palette
		Global.CreatureType.SALAMANDER:
			active_palette = salamander_palette
		Global.CreatureType.MONSTER:
			active_palette = monster_palette

func _on_tree_entered() -> void:
	GlobalSignal.drawing_tool_selected.connect(on_drawing_tool_selected)


func _on_tree_exited() -> void:
	GlobalSignal.drawing_tool_selected.disconnect(on_drawing_tool_selected)
