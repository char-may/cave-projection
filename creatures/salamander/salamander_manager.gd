extends Node2D

@onready var container1 = $Container1
@onready var container2 = $Container2
@onready var container3 = $Container3
@onready var container4 = $Container4

@onready var c1_salamander = $Container1/Path2D/PathFollow2D/Salamander
@onready var c2_salamander = $Container2/Path2D/PathFollow2D/Salamander
@onready var c3_salamander = $Container3/Path2D/PathFollow2D/Salamander
@onready var c4_salamander = $Container4/Path2D/PathFollow2D/Salamander

@onready var cont1_anim = $Container1/AnimationPlayer
@onready var cont2_anim = $Container2/AnimationPlayer
@onready var cont3_anim = $Container3/AnimationPlayer
@onready var cont4_anim = $Container4/AnimationPlayer

var container_states : Array[bool] = [false, false, false, false]
var active_containers : Array[Node2D] = []

func _ready() -> void:
	GlobalSignal.new_salamander_created.connect(new_salamander)

func new_salamander() -> void:
	if active_containers.size() == 3:
		make_space()
	
	var choice = [0, 1, 2, 3]
	choice.shuffle()
	print("Shuffled selection order: " + str(choice))
	
	var selected = false
	for c in choice:
		match c:
			0:
				if container_states[0] != true:
					selected = true
					cont1_active()
			1:
				if container_states[1] != true:
					selected = true
					cont2_active()
			2:
				if container_states[2] != true:
					selected = true
					cont3_active()
			3:
				if container_states[3] != true:
					selected = true
					cont4_active()
			_:
				print("Error in container selection")
		if selected == true:
			break
	
func make_space() -> void:
	var goodbye = active_containers.pop_back()
	match goodbye:
		container1:
			cont1_inactive()
		container2:
			cont2_inactive()
		container3:
			cont3_inactive()
		container4:
			cont4_inactive()
	
func cont1_active() -> void:
	container_states[0] = true
	active_containers.push_front(container1)
	#print("c1 selected")
	#print ("container states: " + str(container_states))
	c1_salamander.reload_texture()
	cont1_anim.play("active")
	
func cont1_inactive() -> void:
	cont1_anim.play_backwards("active")
	await cont1_anim.animation_finished
	container_states[0] = false
	
func cont2_active() -> void:
	container_states[1] = true
	active_containers.push_front(container2)
	#print("c2 selected")
	#print ("container states: " + str(container_states))
	c2_salamander.reload_texture()
	cont2_anim.play("active")
	
func cont2_inactive() -> void:
	cont2_anim.play_backwards("active")
	await cont2_anim.animation_finished
	container_states[1] = false
	
func cont3_active() -> void:
	container_states[2] = true
	active_containers.push_front(container3)
	#print("c3 selected")
	#print ("container states: " + str(container_states))
	c3_salamander.reload_texture()
	cont3_anim.play("active")
	
func cont3_inactive() -> void:
	cont3_anim.play_backwards("active")
	await cont3_anim.animation_finished
	container_states[2] = false
	
func cont4_active() -> void:
	container_states[3] = true
	active_containers.push_front(container4)
	#print("c4 selected")
	#print ("container states: " + str(container_states))
	c4_salamander.reload_texture()
	cont4_anim.play("active")
	
func cont4_inactive() -> void:
	cont4_anim.play_backwards("active")
	await cont4_anim.animation_finished
	container_states[3] = false
	
