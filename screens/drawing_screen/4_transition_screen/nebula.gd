extends Node2D

@export var rotation_speed = 1.0 # Radians per second
@onready var nebula_sprite = $Sprite2D


# Nebula will play scale in animation, and after a delay play scale out and destroy itself
# It will always rotate at the set speed

func _process(delta):
	# Rotate sprite around its own center
	nebula_sprite.rotation += rotation_speed * delta
