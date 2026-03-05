extends Control

@export var on_confirm_2d_scene : String = ""
@export var reload_on_return : bool = false # if false, just remove UI overlay
@export var scene_to_reload : String = ""

func _on_confirm() -> void:
	Global.game_controller.clear_gui_scene()
	Global.game_controller.change_2d_scene(on_confirm_2d_scene, true, false)
	pass
	
func _on_return() -> void:
	# remove ui, optionally reload 2d scene
	Global.game_controller.clear_gui_scene()
	if reload_on_return:
		Global.game_controller.change_2d_scene(scene_to_reload, true, false)
