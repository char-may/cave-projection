extends TextureButton

func _on_pressed() -> void:
	print("make face button pressed")
	Input.action_press("generate_face")
	Input.action_release("generate_face")
