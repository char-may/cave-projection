extends Node

@onready var anim_player = $"../BoingAnimation"
@onready var timer = $"."

func _ready():
	randomize() # Initialize random seed
	timer.start()

func _on_timeout() -> void:
	anim_player.play("Boing")
	timer.wait_time = randf_range(10.0, 45.0)
	timer.start()
	
