@tool
class_name ToolButton extends SwatchButton

@export var time : float = 0.1
@export var transition_type : Tween.TransitionType
@export var slide : Vector2
var default_size : Vector2
var out : bool = false # state

# TODO: Need default color for pen/drawing

func _ready() -> void:
	default_size = size
	slide_in()
	
func _on_swatch_selector_color_selected(selectedColor: Color) -> void:
	color = selectedColor
	await get_tree().create_timer(.01).timeout
	slide_in()

func _on_pressed() -> void:
	if out:
		slide_in()
	else:
		slide_out()
	
func slide_in() -> void:
	add_tween("size", default_size, time)
	out = false

func slide_out() -> void:
	add_tween("size", default_size + slide, time)
	out = true

func add_tween(property: String, value, seconds: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, property, value, seconds).set_trans(transition_type)
