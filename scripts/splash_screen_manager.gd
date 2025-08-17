extends Control

# Splash screen manager:
# Plays splash screen animation and handles scene transition

@export var in_time : float = 0.2
@export var fade_in_time : float = 0.3
@export var pause_time : float = 1.25
@export var fade_out_time : float = 0.3
@export var out_time : float = 0.6
@export var splash_screen : AnimatedSprite2D

func _ready() -> void:
	splash_screen.play()
	fade()
	
func fade() -> void:
	splash_screen.modulate.a = 0.0
	var tween = self.create_tween()
	tween.tween_interval(in_time)
	tween.tween_property(splash_screen, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(splash_screen, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	await tween.finished
	#Global.game_controller.change_gui_scene("res://scenes/empty_gui.tscn", true, false)
	Global.game_controller.change_gui_scene("res://scenes/creature_selection.tscn", true, false)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		Global.game_controller.change_gui_scene("res://scenes/creature_selection.tscn", true, false)
