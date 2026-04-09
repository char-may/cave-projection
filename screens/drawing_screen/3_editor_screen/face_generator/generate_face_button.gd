extends TextureButton

func _on_pressed() -> void:
	GlobalSignal.generate_random_face.emit()
