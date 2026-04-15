extends Node

# Manages the big guys

const BIG_GUY = preload("res://creatures/bigguy/bigguy.tscn")

# nodes
@onready var BGPos1 = $"../BGPos1"
@onready var BGPos2 = $"../BGPos2"
@onready var BGPos3 = $"../BGPos3"
@onready var BGPos4 = $"../BGPos4"
@onready var BGPos5 = $"../BGPos5"
@onready var BGPos6 = $"../BGPos6"

# child flags
@onready var positions : Array[Node2D] = [BGPos1, BGPos2, BGPos3, BGPos4, BGPos5, BGPos6]


# child transforms
# x, y, rotation, scale
const POS1: Array[float] = [692, 76, 180, 0.4]
const POS2: Array[float] = [1508, 190, -135.9, 0.4]
const POS3: Array[float] = [17, 389, 90, 0.6]
const POS4: Array[float] = [473, 1022, 0, 0.6]
const POS5: Array[float] = [1896, 810, -64.9, 0.6]
const POS6: Array[float] = [1034, 1097, 0, 1]

func _ready() -> void:
	GlobalSignal.new_bigguy_created.connect(new_bg)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		new_bg()

func new_bg() -> void:
	positions.shuffle()
	for pos in positions:
		if pos.get_child_count() == 0:
			#print (str(pos) + " has no children")
			var instance = BIG_GUY.instantiate()
			set_instance_parameters(pos, instance)
			pos.add_child(instance)
			break
func set_instance_parameters(p, i):
	match p:
		BGPos1:
			print("BGPos1 Picked")
			i.position.x = POS1[0]
			i.position.y = POS1[1]
			i.rotation_degrees = POS1[2]
			i.scale = Vector2(POS1[3], POS1[3])
		BGPos2:
			print("BGPos2 Picked")
			i.position.x = POS2[0]
			i.position.y = POS2[1]
			i.rotation_degrees = POS2[2]
			i.scale = Vector2(POS2[3], POS2[3])
		BGPos3:
			print("BGPos3 Picked")
			i.position.x = POS3[0]
			i.position.y = POS3[1]
			i.rotation_degrees = POS3[2]
			i.scale = Vector2(POS3[3], POS3[3])
		BGPos4:
			print("BGPos4 Picked")
			i.position.x = POS4[0]
			i.position.y = POS4[1]
			i.rotation_degrees = POS4[2]
			i.scale = Vector2(POS4[3], POS4[3])
		BGPos5:
			print("BGPos5 Picked")
			i.position.x = POS5[0]
			i.position.y = POS5[1]
			i.rotation_degrees = POS5[2]
			i.scale = Vector2(POS5[3], POS5[3])
		BGPos6:
			print("BGPos6 Picked")
			i.position.x = POS6[0]
			i.position.y = POS6[1]
			i.rotation_degrees = POS6[2]
			i.scale = Vector2(POS6[3], POS6[3])
		_:
			print("Nothing matched")
