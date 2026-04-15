extends Node2D

@export var eye_textures: Array[Texture2D]
@export var nose_textures: Array[Texture2D]
@export var mouth_textures: Array[Texture2D]

@export var left_eye : Sprite2D
@export var right_eye : Sprite2D
@export var nose : Sprite2D
@export var mouth : Sprite2D

func _ready() -> void:
	GlobalSignal.generate_random_face.connect(generate_random_face)
	GlobalSignal.remove_random_face.connect(remove_random_face)
	
	match Global.creature_editing:
		Global.CreatureType.BAT:
			left_eye.visible = true
			right_eye.visible = true
			nose.visible = true
			mouth.visible = true
		Global.CreatureType.TARDIGRADE:
			left_eye.visible = true
			right_eye.visible = false
			nose.visible = false
			mouth.visible = false
		Global.CreatureType.SALAMANDER:
			pass
		Global.CreatureType.BIGGUY:
			# positions are original + offset (also scaled up slightly in UI)
			left_eye.visible = true
			
			right_eye.visible = true
			right_eye.position.x = 125 + 200
			
			nose.visible = true
			nose.position.y = 100 + 30
			nose.position.x = 97 + 95
			
			mouth.visible = true
			mouth.position.y = 200 + 50
			mouth.position.x = 100
			

func generate_random_face() -> void:
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
		
func remove_random_face() -> void:
	left_eye.texture = null
	right_eye.texture = null
	nose.texture = null
	mouth.texture = null
