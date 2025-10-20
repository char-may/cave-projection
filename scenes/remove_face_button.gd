extends TextureButton

func _on_pressed() -> void:
	Input.action_press("remove_face")
	Input.action_release("remove_face")
