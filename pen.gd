extends Node2D

@onready var _lines: Node2D = $Line2D

var _pressed: bool = false
var _current_line: Line2D = null
@export var width = 25

var line_color : Color

func _ready():
	line_color = Editor.editing.palette

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

func _on_swatch_selector_color_selected(color: Color) -> void:
	line_color = color
