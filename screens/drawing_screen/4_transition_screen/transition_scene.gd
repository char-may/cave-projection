extends Node2D

@onready var portal_sprite = $Portal/Sprite2D
@onready var creature_container = $CreatureContainer
@onready var label = $CreatureContainer/Label

var normal_font = load("res://fonts/Chubby Fun Regular.ttf")
var bigguy_font = load("res://fonts/Zu-Regular.otf")
 
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
const creature_container_scale_time = 0.65

var bat_greeting_text: Array = [
	"Oi!",
	"Hello!",
	"Hi!",
	"Boa tarde!"]
	
var tardigrade_greeting_text: Array = [
	"Blub blub...",
	"Blub-blub!",
	"Blub!"
]
	
var bat_question_text: Array = [
	"Who turned out the lights?",
	"Onde estou?",
	"What's this weird spinny thing?",
	"Is it time for lunch?"]

var tardigrade_question_text: Array = [
	"Blub blu-blub?",
	"Blub... blub?",
	"... blub-blub?"
]
var bat_exclamation_text: Array = [
	"This looks fun!",
	"I'm glad I packed my bags!",
	"Here we go!",
	"I'm not scared!"]
	
var tardigrade_explamation_text: Array = [
	"Blub-o-blub!",
	"Bluuub!",
	"Ba-blub!",
	"Blub blub!"
]
var rng #random number generator

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	if label.label_settings == null:
		label.label_settings = LabelSettings.new()
	
	label.visible = false
	portal_sprite.scale = portal_starting_scale
	creature_container.scale = creature_container_starting_scale

	match Global.creature_editing:
		Global.CreatureType.BAT:
			label.label_settings.font = normal_font
			label.label_settings.font_size = 50
			bat_selected()
		Global.CreatureType.TARDIGRADE:
			label.label_settings.font = normal_font
			label.label_settings.font_size = 50
			tardigrade_selected()
		Global.CreatureType.SALAMANDER:
			label.label_settings.font = normal_font
			label.label_settings.font_size = 50
			salamander_selected()
		Global.CreatureType.BIGGUY:
			label.label_settings.font = bigguy_font
			label.label_settings.font_size = 75
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
		random_text = bat_greeting_text.pick_random()
		label.text = random_text
	
	await get_tree().create_timer(2).timeout
	label.text = ""
	await get_tree().create_timer(.5).timeout
	
	if Global.creature_editing == Global.CreatureType.TARDIGRADE:
		random_text = tardigrade_question_text.pick_random()
		label.text = random_text
	else:
		random_text = bat_question_text.pick_random()
		label.text = random_text
	
	await get_tree().create_timer(2).timeout
	label.text = ""
	await get_tree().create_timer(.5).timeout
	
	if Global.creature_editing == Global.CreatureType.TARDIGRADE:
		random_text = tardigrade_explamation_text.pick_random()
		label.text = random_text
	else:
		random_text = bat_exclamation_text.pick_random()
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
	var new_salamander_scene := preload("res://creatures/salamander/salamander.tscn")
	var new_salamander = new_salamander_scene.instantiate()
	creature_transitioning = new_salamander
	new_salamander.transitioning = true
	new_salamander.scale = Vector2(.35, .35)
	get_node("CreatureContainer").add_child(new_salamander)
	
func bigguy_selected():
	# spawn big guy
	var new_bigguy_scene := preload("res://creatures/bigguy/bigguy.tscn")
	var new_bigguy = new_bigguy_scene.instantiate()
	creature_transitioning = new_bigguy
	new_bigguy.transitioning = true
	new_bigguy.scale = Vector2(.35, .35)
	get_node("CreatureContainer").add_child(new_bigguy)

func send_to_cave():
	match Global.creature_editing:
		Global.CreatureType.BAT:
			GlobalSignal.new_bat_created.emit()
		Global.CreatureType.TARDIGRADE:
			GlobalSignal.new_tardigrade_created.emit()
		Global.CreatureType.SALAMANDER:
			GlobalSignal.new_salamander_created.emit()
		Global.CreatureType.BIGGUY:
			GlobalSignal.new_bigguy_created.emit()
