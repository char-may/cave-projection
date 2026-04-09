extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	play_animation()
	
func play_animation() -> void:
	animation_player.play("flicker_animation")
	var anim_length = animation_player.current_animation_length
	var random_time = randf_range(0.0, anim_length)
	animation_player.advance(random_time)
	await $AnimationPlayer.animation_finished
	
	# once finished, jump to a random position and start over
	var x = randf_range(0, 1920)
	var y = randf_range(0, 1080)
	position = Vector2(x, y)
	play_animation()
