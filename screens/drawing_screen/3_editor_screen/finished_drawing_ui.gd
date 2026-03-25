extends Node2D

@onready var portal_button = $PortalButton
@onready var portal_label = $PortalButton/PortalLabel
@onready var confirm_button = $ConfirmButton
@onready var back_button = $BackButton
@onready var confirm_label = $ConfirmLabel
@onready var nebula_sprite = $PortalButton/NebulaSprite
@onready var nebula_spritebg = $PortalButton/NebulaSpriteBG
@onready var button_animation = $ButtonAnimation

@export var nebula_rotation_speed = 1.0 # Radians per second
@export var nebula_scale_to : Vector2
@export var nebulabg_scale_to : Vector2
@export var nebula_scale_in_time = 2.0

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	portal_button.visible = true
	portal_button.disabled = false
	portal_label.visible = true
	portal_label.modulate.a = 0.0
	nebula_sprite.visible = true
	nebula_spritebg.visible = true
	confirm_button.visible = false
	back_button.visible = false
	confirm_label.visible = false
	
	var scale_in_nebula = create_tween()
	var scale_in_nebulabg = create_tween()
	scale_in_nebula.tween_property(nebula_sprite,"scale", nebula_scale_to, nebula_scale_in_time).set_trans(Tween.TRANS_CUBIC)
	scale_in_nebulabg.tween_property(nebula_spritebg,"scale", nebulabg_scale_to, nebula_scale_in_time).set_trans(Tween.TRANS_CUBIC)
	await get_tree().create_timer(.5).timeout
	var fade_in_portal_label = create_tween()
	fade_in_portal_label.tween_property(portal_label, "modulate:a", 1.0, nebula_scale_in_time).set_trans(Tween.TRANS_CUBIC)

func _process(delta):
	# Rotate sprite around its own center
	nebula_sprite.rotation += nebula_rotation_speed * delta
	nebula_spritebg.rotation += nebula_rotation_speed * delta

func _on_portal_button_pressed() -> void:
	portal_button.visible = true
	portal_label.visible = true
	confirm_button.visible = true
	back_button.visible = true
	confirm_label.visible = true
	
	portal_button.disabled = true
	button_animation.play("BUTTONS")

func _on_confirm_button_pressed() -> void:
	GlobalSignal.finished_drawing.emit()
	
	var big_nebula = create_tween()
	var big_nebulabg = create_tween()
	big_nebula.tween_property(nebula_sprite,"scale", Vector2(5.0, 5.0), 1.3).set_trans(Tween.TRANS_CUBIC)
	big_nebulabg.tween_property(nebula_spritebg,"scale", Vector2(5.0, 5.0),1.3).set_trans(Tween.TRANS_CUBIC)
	portal_button.visible = true
	portal_label.visible = false
	confirm_button.visible = false
	confirm_label.visible = false
	back_button.visible = false
	await big_nebula.finished
	Global.game_controller.clear_gui_scene()
	Global.game_controller.change_2d_scene("res://screens/drawing_screen/4_transition_screen/transition_scene.tscn", true, false)

func _on_back_button_pressed() -> void:
	portal_button.visible = true
	portal_label.visible = true
	nebula_sprite.visible = true
	nebula_spritebg.visible = true
	button_animation.play_backwards("BUTTONS")
	await button_animation.animation_finished
	portal_button.disabled = false
	confirm_button.visible = false
	back_button.visible = false
	confirm_label.visible = false
