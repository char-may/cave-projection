extends Node2D

@export var eye_textures: Array[Texture2D]
@export var nose_textures: Array[Texture2D]
@export var mouth_textures: Array[Texture2D]

@export var left_eye : Sprite2D
@export var right_eye : Sprite2D
@export var nose : Sprite2D
@export var mouth : Sprite2D

func _process(_delta):
	if Input.is_action_just_pressed("generate_face"):
		print("Make a silly face!")
		
		#Set random eyes
		var random_eye_index = randi_range(0, eye_textures.size() - 1)
		left_eye.texture = eye_textures[random_eye_index]
		right_eye.texture = eye_textures[random_eye_index]
		
		#Set random nose
		var random_nose_index = randi_range(0, nose_textures.size() - 1)
		nose.texture = nose_textures[random_nose_index]
		
		#Set random mouth
		var random_mouth_index = randi_range(0, mouth_textures.size() - 1)
		mouth.texture = mouth_textures[random_mouth_index]
		
	if Input.is_action_just_pressed("remove_face"):
		print("Remove silly face")
		left_eye.texture = null
		right_eye.texture = null
		nose.texture = null
		mouth.texture = null
