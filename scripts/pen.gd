extends Node2D

# Pen:
# Draws lines with mouse input

# Signals:
# Recieves -> Swatch color selected, Drawing tool selected

@onready var _lines: Node2D = $Line2D

var width = 25
var _pressed: bool = false
var _current_line: Line2D = null
var line_color : Color

func _ready():
	pass
	#line_color = Editor.editing.palette

func _process(_delta):
	var pos = get_global_mouse_position()
	
	if Input.is_action_pressed("ui_left_click"):
		_pressed = true
		_current_line = Line2D.new()
		_current_line.begin_cap_mode = Line2D.LINE_CAP_ROUND
		_current_line.end_cap_mode = Line2D.LINE_CAP_ROUND
		_current_line.joint_mode = Line2D.LINE_JOINT_ROUND
		
		_current_line.default_color = line_color
		_current_line.width = width
		
		_lines.add_child(_current_line)
		_current_line.add_point(pos)
	else:
		_pressed = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and _pressed:
		_current_line.add_point(event.position)

func on_swatch_color_selected(color: Color) -> void:
	line_color = color

func on_drawing_tool_selected(size) -> void:
		width = size

func _on_tree_entered() -> void:
	GlobalSignal.drawing_tool_selected.connect(on_drawing_tool_selected)
	GlobalSignal.swatch_color_selected.connect(on_swatch_color_selected)

func _on_tree_exited() -> void:
	GlobalSignal.drawing_tool_selected.disconnect(on_drawing_tool_selected)
	GlobalSignal.swatch_color_selected.disconnect(on_swatch_color_selected)
