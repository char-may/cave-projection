extends Node

# Manages the big guys

const BIG_GUY = preload("res://creatures/bigguy/bigguy.tscn")
const BIG_GUY_HANDS = preload("res://creatures/bigguy/bigguy_hands.tscn")

# nodes
@onready var BGPos1 = $"../BGPos1"
@onready var BGPos2 = $"../BGPos2"
@onready var BGPos3 = $"../BGPos3"
@onready var BGPos4 = $"../BGPos4"
@onready var BGPos5 = $"../BGPos5"
@onready var BGPos6 = $"../BGPos6"

# for picking random available position
@onready var positions : Array[Node2D] = [BGPos1, BGPos2, BGPos3, BGPos4, BGPos5, BGPos6]

var active_guys : Array[BigGuy] = []

# child transforms
# x, y, rotation, scale
const POS1: Array[float] = [692, 76, 180, 0.4]
const POS2: Array[float] = [1508, 190, -150.6, 0.4]
const POS3: Array[float] = [17, 389, 90, 0.6]
const POS4: Array[float] = [473, 1022, 0, 0.6]
const POS5: Array[float] = [1894, 720, -79.6, 0.6]
const POS6: Array[float] = [1034, 1097, 0, 1]

const HANDSPOS1: Array[float] = [701, 195, 180, 0.4]
const HANDSPOS2: Array[float] = [1452, 325, 195.9, 0.4]
const HANDSPOS3: Array[float] = [266, 417, 93.1, 0.6]
const HANDSPOS4: Array[float] = [523, 768, 9.8, 0.6]
const HANDSPOS5: Array[float] = [1588, 650, -78.4, 0.6]
const HANDSPOS6: Array[float] = [1020, 678, 0, 1.0]

func _ready() -> void:
	GlobalSignal.new_bigguy_created.connect(new_bigguy)
	GlobalSignal.bigguy_animation_finished.connect(move_bigguy)
	
func new_bigguy() -> void:
	# find available position and keep only 3 active positions, bumping the oldest
	if active_guys.size() == 3:
		make_room_for_new_bigguy()
	
	positions.shuffle()
	for pos in positions:
		if pos.get_child_count() == 0:
			var bg_instance = BIG_GUY.instantiate()
			var bg_hands_instance = BIG_GUY_HANDS.instantiate()
			set_instance_parameters(pos, bg_instance)
			set_instance_parameters(pos, bg_hands_instance)
			bg_instance.hands = bg_hands_instance
			pos.add_child(bg_hands_instance)
			pos.add_child(bg_instance)
			active_guys.push_front(bg_instance)
			break
	
func make_room_for_new_bigguy() -> void:
	var goodbye_guy = active_guys.pop_back()
	var goodbye_guy_hands = goodbye_guy.hands
	await goodbye_guy.get_node("AnimationPlayer").animation_finished
	goodbye_guy_hands.queue_free()
	goodbye_guy.queue_free()
	
func move_bigguy(bg) -> void:
	positions.shuffle()
	for pos in positions:
		if pos.get_child_count() == 0:
			set_instance_parameters(pos, bg)
			bg.reparent(pos)
			if bg.hands != null:
				bg.hands.animation_player.play("off")
				await bg.hands.animation_player.animation_finished
				set_instance_parameters(pos, bg.hands)
				bg.hands.reparent(pos)
			break
func set_instance_parameters(p, i):
	match p:
		BGPos1:
			if i is BigGuy:
				i.position.x = POS1[0]
				i.position.y = POS1[1]
				i.rotation_degrees = POS1[2]
				i.scale = Vector2(POS1[3], POS1[3])
			elif i is BigGuyHands:
				i.position.x = HANDSPOS1[0]
				i.position.y = HANDSPOS1[1]
				i.rotation_degrees = HANDSPOS1[2]
				i.scale = Vector2(HANDSPOS1[3], HANDSPOS1[3])
		BGPos2:
			if i is BigGuy:
				i.position.x = POS2[0]
				i.position.y = POS2[1]
				i.rotation_degrees = POS2[2]
				i.scale = Vector2(POS2[3], POS2[3])
			elif i is BigGuyHands:
				i.position.x = HANDSPOS2[0]
				i.position.y = HANDSPOS2[1]
				i.rotation_degrees = HANDSPOS2[2]
				i.scale = Vector2(HANDSPOS2[3], HANDSPOS2[3])
		BGPos3:
			if i is BigGuy:
				i.position.x = POS3[0]
				i.position.y = POS3[1]
				i.rotation_degrees = POS3[2]
				i.scale = Vector2(POS3[3], POS3[3])
			elif i is BigGuyHands:
				i.position.x = HANDSPOS3[0]
				i.position.y = HANDSPOS3[1]
				i.rotation_degrees = HANDSPOS3[2]
				i.scale = Vector2(HANDSPOS3[3], HANDSPOS3[3])
		BGPos4:
			if i is BigGuy:
				i.position.x = POS4[0]
				i.position.y = POS4[1]
				i.rotation_degrees = POS4[2]
				i.scale = Vector2(POS4[3], POS4[3])
			elif i is BigGuyHands:
				i.position.x = HANDSPOS4[0]
				i.position.y = HANDSPOS4[1]
				i.rotation_degrees = HANDSPOS4[2]
				i.scale = Vector2(HANDSPOS4[3], HANDSPOS4[3])
		BGPos5:
			if i is BigGuy:
				i.position.x = POS5[0]
				i.position.y = POS5[1]
				i.rotation_degrees = POS5[2]
				i.scale = Vector2(POS5[3], POS5[3])
			elif i is BigGuyHands:
				i.position.x = HANDSPOS5[0]
				i.position.y = HANDSPOS5[1]
				i.rotation_degrees = HANDSPOS5[2]
				i.scale = Vector2(HANDSPOS5[3], HANDSPOS5[3])
		BGPos6:
			if i is BigGuy:
				i.position.x = POS6[0]
				i.position.y = POS6[1]
				i.rotation_degrees = POS6[2]
				i.scale = Vector2(POS6[3], POS6[3])
			elif i is BigGuyHands:
				i.position.x = HANDSPOS6[0]
				i.position.y = HANDSPOS6[1]
				i.rotation_degrees = HANDSPOS6[2]
				i.scale = Vector2(HANDSPOS6[3], HANDSPOS6[3])
		_:
			print("Nothing matched")
