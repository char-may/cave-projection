extends Node2D

@onready var portal_sprite = $Portal/Sprite2D
@onready var background_portal_sprite = $BackgroundPortal/Sprite2D
@onready var creature_container = $CreatureContainer
@onready var label = $CreatureContainer/Label

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
	"Hey...",
	"Hi!",
	"Sup!",
	"Bonjour!",
	"Hello!",
	"Aloha!"]
	
var question_text: Array = [
	"Who turned out the lights?",
	"I'm... alive?",
	"Where am I?",
	"What's this weird spinny thing?",
	"Is it time for lunch?"]

var subject_change_text: Array = [
	"Anyway...",
	"On that note...",
	"Okay... so...",
	"If you say so!"]

var exclamation_text: Array = [
	"I think it's going to swallow me up now!",
	"This looks... fun!",
	"I think I read about this somewhere!",
	"I'm glad I packed my bags!"]
	
var goodbye_text: Array = [
	"Bye bye!",
 	"Hasta luego!",
	"Toodle-oo!",
	"See ya!",
	"Sayonara!"]

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

	var scale_background_portal = create_tween()
	
	#creature dialog (add randomized options)
	await scale_creature_container.finished
	label.visible = true
	label.text = "Oh..."
	await get_tree().create_timer(1).timeout
	label.text = ""
	await get_tree().create_timer(.5).timeout
	var random_text: String = greeting_text.pick_random()
	label.text = random_text
	
	await get_tree().create_timer(2).timeout
	label.text = ""
	await get_tree().create_timer(.5).timeout
	random_text = question_text.pick_random()
	label.text = random_text
	
	await get_tree().create_timer(2).timeout
	label.text = ""
	await get_tree().create_timer(.5).timeout
	label.text = "..."
	await get_tree().create_timer(2).timeout
	label.text = ""
	await get_tree().create_timer(.5).timeout
	random_text = subject_change_text.pick_random()
	label.text = random_text
	
	await get_tree().create_timer(1).timeout
	label.text = ""
	await get_tree().create_timer(.5).timeout
	random_text = exclamation_text.pick_random()
	label.text = random_text
	
	await get_tree().create_timer(3).timeout
	label.text = ""
	await get_tree().create_timer(.5).timeout
	random_text = goodbye_text.pick_random()
	label.text = random_text
	
	await get_tree().create_timer(2).timeout
	label.visible = false
	creature_rotating = true
	
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
	new_bat.scale = Vector2(.35, .35)
	var new_bat_container = new_bat.get_node("Container")
	new_bat_container.disabled = true #turn off wiggle animation
	get_node("CreatureContainer").add_child(new_bat)

func tardigrade_selected():
	pass
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
