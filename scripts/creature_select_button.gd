class_name CreatureSelectButton extends TextureButton

@export var creature_type : Global.CreatureType
@export var frame_a : Texture2D
@export var frame_b : Texture2D

var current_frame : Texture2D

func _ready() -> void:	
	current_frame = frame_a
	texture_normal = current_frame

func _process(_delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	if current_frame == frame_a:
		current_frame = frame_b
	else:
		current_frame = frame_a
	
	texture_normal = current_frame

func _on_pressed() -> void:
	pass # Replace with function body.
