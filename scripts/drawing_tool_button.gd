@tool
class_name DrawingToolButton extends ColorButton

# Drawing tool button:
# Represents drawing tool as a color button
# Does a slide in/out tween animation when pressed

# Signals:
# Emit -> Drawing tool selected (tool type, size)
# Recieve -> Swatch color selected

@export var type : Global.ToolType
@export var tool_size : int

@export var slide_time : float = 0.1
@export var transition_type : Tween.TransitionType
@export var slide_offset : Vector2

@export var inactive_color : Color

# TODO: add unselected default color...
# TODO: load a default selected color...

var active : bool = false # Tool active/selected
var button_size : Vector2
var out : bool = false # state TODO: rename to active or something

# TODO: Need default color for pen/drawing
# TODO: Set palette resource and default based on creature type editing

func _ready() -> void:
	GlobalSignal.swatch_color_selected.connect(on_swatch_color_selected)
	button_size = size
	if !active:
		color = inactive_color
		slide_in()

func _process(_delta: float) -> void:
	if Global.selected_tool == type:
		active = true
	else:
		active = false
		color = inactive_color
		slide_in()
	
func on_swatch_color_selected(selectedColor: Color) -> void:
	if active:
		color = selectedColor
		await get_tree().create_timer(.01).timeout
		slide_in()

func _on_pressed() -> void:
	Global.selected_tool = type
	GlobalSignal.drawing_tool_selected.emit(tool_size)
	if out:
		slide_in()
	else:
		slide_out()
	
func slide_in() -> void:
	add_tween("size", button_size, slide_time)
	out = false

func slide_out() -> void:
	add_tween("size", button_size + slide_offset, slide_time)
	out = true

func add_tween(property: String, value, seconds: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, property, value, seconds).set_trans(transition_type)

func _on_tree_exiting() -> void:
	if GlobalSignal.swatch_color_selected:
		GlobalSignal.swatch_color_selected.disconnect(on_swatch_color_selected)
