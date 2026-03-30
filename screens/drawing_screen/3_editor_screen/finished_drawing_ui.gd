extends Node2D

@onready var portal_button = $PortalButton
@onready var portal_label = $PortalButton/PortalLabel
@onready var confirm_button = $ConfirmButton
@onready var back_button = $BackButton
@onready var confirm_label = $ConfirmLabel
@onready var portal_sprite = $PortalButton/PortalSprite
@onready var portal_spritebg = $PortalButton/PortalSpriteBG
@onready var button_animation = $ButtonAnimation

@export var portal_rotation_speed = 1.0 # Radians per second
@export var portal_scale_to : Vector2
@export var portalbg_scale_to : Vector2
@export var portal_scale_in_time : float = 2.0

@export var portal_appear_delay : float = 5.0

func _ready() -> void:
	await get_tree().create_timer(portal_appear_delay).timeout
	portal_button.visible = true
	portal_button.disabled = false
	portal_label.visible = true
	portal_label.modulate.a = 0.0
	portal_sprite.visible = true
	portal_spritebg.visible = true
	confirm_button.visible = false
	back_button.visible = false
	confirm_label.visible = false
	
	var scale_in_portal = create_tween()
	var scale_in_portalbg = create_tween()
	scale_in_portal.tween_property(portal_sprite,"scale", portal_scale_to, portal_scale_in_time).set_trans(Tween.TRANS_CUBIC)
	scale_in_portalbg.tween_property(portal_spritebg,"scale", portalbg_scale_to, portal_scale_in_time).set_trans(Tween.TRANS_CUBIC)
	await get_tree().create_timer(.5).timeout
	var fade_in_portal_label = create_tween()
	fade_in_portal_label.tween_property(portal_label, "modulate:a", 1.0, portal_scale_in_time).set_trans(Tween.TRANS_CUBIC)

func _process(delta):
	# Rotate sprite around its own center
	portal_sprite.rotation += portal_rotation_speed * delta
	portal_spritebg.rotation += portal_rotation_speed * delta

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
	
	var big_portal = create_tween()
	var big_portalbg = create_tween()
	big_portal.tween_property(portal_sprite,"scale", Vector2(5.0, 5.0), 1.3).set_trans(Tween.TRANS_CUBIC)
	big_portalbg.tween_property(portal_spritebg,"scale", Vector2(5.0, 5.0),1.3).set_trans(Tween.TRANS_CUBIC)
	portal_button.visible = true
	portal_label.visible = false
	confirm_button.visible = false
	confirm_label.visible = false
	back_button.visible = false
	await big_portal.finished
	Global.game_controller.clear_gui_scene()
	Global.game_controller.change_2d_scene("res://screens/drawing_screen/4_transition_screen/transition_scene.tscn", true, false)

func _on_back_button_pressed() -> void:
	portal_button.visible = true
	portal_label.visible = true
	portal_sprite.visible = true
	portal_spritebg.visible = true
	button_animation.play_backwards("BUTTONS")
	await button_animation.animation_finished
	portal_button.disabled = false
	confirm_button.visible = false
	back_button.visible = false
	confirm_label.visible = false
