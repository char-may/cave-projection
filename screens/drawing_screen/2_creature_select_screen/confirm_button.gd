extends TextureButton

# simple button animation
func _on_timer_timeout() -> void:
	if !flip_h:
		flip_h = true
	else:
		flip_h = false
