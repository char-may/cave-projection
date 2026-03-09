extends Node2D

@onready var portal_button = $PortalButton
@onready var portal_label = $PortalButton/PortalLabel
@onready var confirm_button = $ConfirmButton
@onready var back_button = $BackButton
@onready var confirm_label = $ConfirmLabel
@onready var nebula_sprite = $PortalButton/NebulaSprite
@onready var button_animation = $ButtonAnimation

@export var nebula_rotation_speed = 1.0 # Radians per second
@export var nebula_scale_to : Vector2
@export var nebula_scale_in_time = 2.0

func _ready() -> void:
	portal_button.visible = true
	portal_button.disabled = false
	portal_label.visible = true
	portal_label.modulate.a = 0.0
	nebula_sprite.visible = true
	confirm_button.visible = false
	back_button.visible = false
	confirm_label.visible = false
	
	var scale_in_nebula = create_tween()
	scale_in_nebula.tween_property(nebula_sprite,"scale", nebula_scale_to, nebula_scale_in_time).set_trans(Tween.TRANS_CUBIC)
	await get_tree().create_timer(.5).timeout
	var fade_in_portal_label = create_tween()
	fade_in_portal_label.tween_property(portal_label, "modulate:a", 1.0, nebula_scale_in_time).set_trans(Tween.TRANS_CUBIC)

func _process(delta):
	# Rotate sprite around its own center
	nebula_sprite.rotation += nebula_rotation_speed * delta

func _on_portal_button_pressed() -> void:
	portal_button.visible = true
	portal_label.visible = true
	confirm_button.visible = true
	back_button.visible = true
	confirm_label.visible = true
	
	portal_button.disabled = true
	button_animation.play("BUTTONS")

func _on_confirm_button_pressed() -> void:
	pass # Replace with function body.

func _on_back_button_pressed() -> void:
	portal_button.visible = true
	portal_label.visible = true
	nebula_sprite.visible = true
	button_animation.play_backwards("BUTTONS")
	await button_animation.animation_finished
	portal_button.disabled = false
	confirm_button.visible = false
	back_button.visible = false
	confirm_label.visible = false
