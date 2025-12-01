extends TextureButton

func _on_pressed() -> void:

	Input.action_press("generate_face")
	Input.action_release("generate_face")
