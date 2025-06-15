@tool
class_name DrawingToolButton extends ColorButton

# Drawing tool button:
# Represents drawing tool as a color button
# Does a slide in/out tween animation when pressed

# Signals:
# Emit -> Drawing tool selected (tool type, size)
# Recieve -> Swatch color selected

@export var type : Global.ToolType = Global.ToolType.PEN
@export var tool_size : int

@export var slide_time : float = 0.1
@export var transition_type : Tween.TransitionType
@export var slide_offset : Vector2

#TODO: add unselected default color...
#TODO: load a default selected color...

var button_size : Vector2
var out : bool = false # state TODO: rename to active or something

# TODO: Need default color for pen/drawing
# TODO: Set palette resource and default based on creature type editing

func _ready() -> void:
	GlobalSignal.swatch_color_selected.connect(on_swatch_color_selected)
	button_size = size
	slide_in()
	
func on_swatch_color_selected(selectedColor: Color) -> void:
	color = selectedColor
	await get_tree().create_timer(.01).timeout
	slide_in()

func _on_pressed() -> void:
	GlobalSignal.drawing_tool_selected.emit(type, tool_size)
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
