class_name DrawingToolButton extends TextureButton

# Drawing tool button:
# Represents drawing tool as a color button
# Does a slide in/out tween animation when pressed

# Signals:
# Emit -> Drawing tool selected, Swatch color selected
# Recieve -> Swatch color selected

# Tool type stuff
@export var type : Global.ToolType
@export var tool_size : int

# Animation stuff
@export var slide_time : float = 0.1
@export var transition_type : Tween.TransitionType
@export var slide_offset : Vector2

# Color stuff
@export var inactive_color : Color
var default_color : Color
var active_color : Color

# Tool state
var active : bool = false
var button_pos : Vector2
var currently_out : bool = false

# TODO: Set palette resource and default based on creature type editing

func _ready() -> void:
	GlobalSignal.swatch_color_selected.connect(on_swatch_color_selected)
	button_pos = position
	
	# Set tool defaults
	if type == Global.selected_tool:
		active = true
		var swatch_selector = get_node("SwatchSelector")
		default_color = swatch_selector.active_palette.color1
		active_color = default_color
		GlobalSignal.set_default_color.emit(default_color)
		GlobalSignal.set_default_size.emit(tool_size)
		slide_in()
	
	if !active:
		active_color = inactive_color
		slide_in()
	
func _process(_delta: float) -> void:
	if Global.selected_tool == type:
		active = true
	else:
		active = false
		active_color = inactive_color
		slide_in()
	
func on_swatch_color_selected(selectedColor: Color) -> void:
	if active:
		active_color = selectedColor
		await get_tree().create_timer(.01).timeout
		slide_in()

func _on_pressed() -> void:
	Global.selected_tool = type
	GlobalSignal.drawing_tool_selected.emit(tool_size)
	if currently_out:
		slide_in()
	else:
		slide_out()
	
func slide_in() -> void:
	add_tween("position", button_pos, slide_time)
	currently_out = false

func slide_out() -> void:
	add_tween("position", position + slide_offset, slide_time)
	currently_out = true

func add_tween(property: String, value, seconds: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, property, value, seconds).set_trans(transition_type)

func _on_tree_exiting() -> void:
	if GlobalSignal.swatch_color_selected:
		GlobalSignal.swatch_color_selected.disconnect(on_swatch_color_selected)
