class_name BigGuyHands extends Node2D

@onready var right_hand = $Container/RHand
@onready var left_hand = $Container/LHand
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	animation_player.play("RESET")
	for child in right_hand.get_children():
		if child is Polygon2D:
			child.texture = Global.finished_atlus
	for child in left_hand.get_children():
		if child is Polygon2D:
			child.texture = Global.finished_atlus
func off():
	animation_player.play("off")
func on():
	animation_player.play("on")
