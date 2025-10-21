extends TextureButton

@export var button_confirms : bool = true # if false button will go back

func _on_timer_timeout() -> void:
	if !flip_h:
		flip_h = true
	else:
		flip_h = false

func _on_pressed() -> void:
	if button_confirms:
		Global.game_controller.change_gui_scene("res://screens/3_editor_screen/editor_ui.tscn", true, false)
		Global.game_controller.change_2d_scene("res://screens/3_editor_screen/editor_screen.tscn", true, false)
	else:
		Global.game_controller.change_gui_scene("res://screens/2_creature_select_screen/creature_select_screen.tscn", true, false)
