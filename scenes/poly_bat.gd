extends Sprite2D


func _on_timer_timeout() -> void:
	if !flip_v:
		flip_v = true
	else:
		flip_v = false
