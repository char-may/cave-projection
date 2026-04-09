extends TextureButton

func _on_pressed() -> void:
	GlobalSignal.remove_random_face.emit()
