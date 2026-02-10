extends Node

@export var open_eyes : Texture2D
@export var closed_eyes : Texture2D

@onready var generate_button_left_eye = $GenerateFaceButton/LeftEye
@onready var generate_button_right_eye = $GenerateFaceButton/RightEye
@onready var remove_button = $RemoveFaceButton

func _ready() -> void:
	if remove_button.visible:
		remove_button.visible = false
	generate_button_left_eye.texture = closed_eyes
	generate_button_right_eye.texture = closed_eyes
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("generate_face"):
		if remove_button.visible == false:
			remove_button.visible = true
		generate_button_left_eye.texture = open_eyes
		generate_button_right_eye.texture = open_eyes
	
	if Input.is_action_just_pressed("remove_face"):
		if remove_button.visible:
			remove_button.visible = false
		generate_button_left_eye.texture = closed_eyes
		generate_button_right_eye.texture = closed_eyes
