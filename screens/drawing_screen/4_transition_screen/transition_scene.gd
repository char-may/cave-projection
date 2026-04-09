extends Node2D

@onready var portal_sprite = $Portal/Sprite2D
@onready var creature_container = $CreatureContainer
@onready var label = $CreatureContainer/Label

var creature_transitioning = null
var creature_rotating : bool = false

const portal_rotation_speed = 1.0 # Radians per second
const creature_container_rotation_speed = 10.0 # Radians per second

const portal_starting_scale = Vector2(3.0,3.0)
const portal_scale_to = Vector2(1.5,1.5)
const portal_scale_time = 0.75

const goodbye_portal_scale_time = 1.5

const creature_container_starting_scale = Vector2(0.0, 0.0)
const creature_container_scale_to = Vector2(1.0, 1.0)
const creature_container_scale_time = 0.75

var greeting_text: Array = [
	"Hey!",
	"Hi!",
	"Sup!",
	"Bonjour!",
	"Hello!",
	"Aloha!"]
	
var tardigrade_greeting_text: Array = [
	"Blub blub!",
	"Bla-blub!",
	"Blub!"
]
	
var question_text: Array = [
	"Who turned out the lights?",
	"I'm... alive?",
	"Where am I?",
	"What's this weird spinny thing?",
	"Is it time for lunch?",
	"Did you draw me?",
	"Which way to the lights out exhibit?",
	"It's so... dark in here!"]

var tardigrade_question_text: Array = [
	"Blub blu-blub?",
	"Blub... blub?",
	"Blub-a-blub-a-blub?",
	"A-blub-bla-blub?",
	"... blub-blub?"
]
var exclamation_text: Array = [
	"I think it's going to swallow me up now!",
	"This looks... fun!",
	"I think I read about this somewhere!",
	"I'm glad I packed my bags!",
	"Let's take a look inside!",
	"I see something on the other side!",
	"I hear my friends calling!",
	"Here we go!",
	"I'm not scared..."]
	
var tardigrade_explamation_text: Array = [
	"Blub-o-blub!",
	"O blub ba-blub!",
	"Bluuuuub!",
	"Ba ba ba blubbbb!",
	"O blub ba-blub blub!"
]
var rng #random number generator

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	label.visible = false
	portal_sprite.scale = portal_starting_scale
	creature_container.scale = creature_container_starting_scale

	match Global.creature_editing:
		Global.CreatureType.BAT:
			bat_selected()
		Global.CreatureType.TARDIGRADE:
			tardigrade_selected()
		Global.CreatureType.SALAMANDER:
			salamander_selected()
		Global.CreatureType.BIGGUY:
			bigguy_selected()
	
	var scale_creature_container = create_tween()
	scale_creature_container.tween_property(creature_container,"scale", creature_container_scale_to, creature_container_scale_time).set_trans(Tween.TRANS_CUBIC)

	var scale_portal = create_tween()
	scale_portal.tween_property(portal_sprite,"scale", portal_scale_to, portal_scale_time).set_trans(Tween.TRANS_CUBIC)
	
	#creature dialog (add randomized options)
	await scale_creature_container.finished
	label.visible = true
	var random_text: String
	
	if Global.creature_editing == Global.CreatureType.TARDIGRADE:
		random_text = tardigrade_greeting_text.pick_random()
		label.text = random_text
	else:
		random_text = greeting_text.pick_random()
		label.text = random_text
	
	await get_tree().create_timer(2).timeout
	label.text = ""
	await get_tree().create_timer(.5).timeout
	
	if Global.creature_editing == Global.CreatureType.TARDIGRADE:
		random_text = tardigrade_question_text.pick_random()
		label.text = random_text
	else:
		random_text = question_text.pick_random()
		label.text = random_text
	
	await get_tree().create_timer(2).timeout
	label.text = ""
	await get_tree().create_timer(.5).timeout
	
	if Global.creature_editing == Global.CreatureType.TARDIGRADE:
		random_text = tardigrade_explamation_text.pick_random()
		label.text = random_text
	else:
		random_text = exclamation_text.pick_random()
		label.text = random_text
	
	await get_tree().create_timer(2).timeout
	label.visible = false
	creature_rotating = true
	
	# stop animation while transitioning
	for child in creature_transitioning.get_children():
		if child is AnimationPlayer:
			child.stop()
	
	var goodbye_portal = create_tween()
	goodbye_portal.tween_property(portal_sprite,"scale", Vector2(0,0), goodbye_portal_scale_time).set_trans(Tween.TRANS_CUBIC)
	var goodbye_creature = create_tween()
	goodbye_creature.tween_property(creature_container,"scale",Vector2(0,0),goodbye_portal_scale_time).set_trans(Tween.TRANS_CUBIC)
	await goodbye_creature.finished
	send_to_cave()
	Global.game_controller.clear_gui_scene()
	Global.game_controller.change_2d_scene("res://screens/drawing_screen/1_splash_screen/splash_screen_manager.tscn")

func _process(delta: float) -> void:
	portal_sprite.rotation += portal_rotation_speed * delta
	if creature_rotating:
		creature_container.rotation += creature_container_rotation_speed * delta
	
func bat_selected():
	# spawn bat
	var new_bat_scene := preload("res://creatures/bat/bat.tscn")
	var new_bat = new_bat_scene.instantiate()
	creature_transitioning = new_bat
	new_bat.scale = Vector2(.35, .35)
	var new_bat_container = new_bat.get_node("Container")
	new_bat_container.disabled = true #turn off wiggle animation
	get_node("CreatureContainer").add_child(new_bat)
	
func tardigrade_selected():
	var new_tardigrade_scene := preload("res://creatures/tardigrade/tardigrade.tscn")
	var new_tardigrade = new_tardigrade_scene.instantiate()
	new_tardigrade.scale = Vector2(.35, .35)
	creature_transitioning = new_tardigrade
	
	# disable wiggle, rotate, and boing animations during transition
	var new_tardigrade_container = new_tardigrade.get_node("Container")
	new_tardigrade_container.disabled = true #turn off wiggle animation
	var new_tardigrade_rotate_anim = new_tardigrade.get_node("RotateAnimation")
	new_tardigrade_rotate_anim.queue_free()
	var new_tardigrade_boing_timer = new_tardigrade.get_node("BoingTimer")
	new_tardigrade_boing_timer.queue_free()
	
	get_node("CreatureContainer").add_child(new_tardigrade)
	
func salamander_selected():
	pass
func bigguy_selected():
	pass

func send_to_cave():
	match Global.creature_editing:
		Global.CreatureType.BAT:
			GlobalSignal.new_bat_created.emit()
		Global.CreatureType.TARDIGRADE:
			GlobalSignal.new_tardigrade_created.emit()
		Global.CreatureType.SALAMANDER:
			GlobalSignal.new_bat_created.emit()
		Global.CreatureType.BIGGUY:
			GlobalSignal.new_bat_created.emit()
