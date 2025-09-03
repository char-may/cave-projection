extends TextureButton


func _on_timer_timeout() -> void:
	if !flip_h:
		flip_h = true
	else:
		flip_h = false


func _on_pressed() -> void:
	Global.game_controller.change_gui_scene("res://scenes/creature_selection.tscn", true, false)
