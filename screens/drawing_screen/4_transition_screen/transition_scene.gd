extends Node2D


@onready var portal_sprite = $Portal/Sprite2D
@onready var creature_container = $CreatureContainer
@onready var label = $CreatureContainer/Label

var creature_rotating : bool = false

const portal_rotation_speed = 1.0 # Radians per second
const creature_container_rotation_speed = 8.0 # Radians per second
const portal_starting_scale = Vector2(3.0,3.0)
const portal_scale_to = Vector2(1.5,1.5)
const portal_scale_time = 0.75
const goodbye_portal_scale_time = 1.5
const creature_container_starting_scale = Vector2(0.0, 0.0)
const creature_container_scale_to = Vector2(1.0, 1.0)
const creature_container_scale_time = 0.75

func _ready() -> void:
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
		Global.CreatureType.MONSTER:
			monster_selected()
	
	var scale_creature_container = create_tween()
	scale_creature_container.tween_property(creature_container,"scale", creature_container_scale_to, creature_container_scale_time).set_trans(Tween.TRANS_CUBIC)

	var scale_portal = create_tween()
	scale_portal.tween_property(portal_sprite,"scale", portal_scale_to, portal_scale_time).set_trans(Tween.TRANS_CUBIC)

	#creature dialog (add randomized options)
	await scale_creature_container.finished
	label.visible = true
	label.text = "Hey..."
	await get_tree().create_timer(2).timeout
	label.text = "Who turned out the lights?"
	await get_tree().create_timer(2).timeout
	label.text = "..."
	await get_tree().create_timer(.5).timeout
	label.text = "...get it?"
	await get_tree().create_timer(1).timeout
	label.text = "Well... Anyway..."
	await get_tree().create_timer(1).timeout
	label.text = "I think it's going to swallow me up now!"
	await get_tree().create_timer(1.5).timeout
	label.text = "Bye bye!"
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
func monster_selected():
	pass

func send_to_cave():
	match Global.creature_editing:
		Global.CreatureType.BAT:
			GlobalSignal.new_bat_created.emit()
		Global.CreatureType.TARDIGRADE:
			GlobalSignal.new_tardigrade_created.emit()
		Global.CreatureType.SALAMANDER:
			GlobalSignal.new_bat_created.emit()
		Global.CreatureType.MONSTER:
			GlobalSignal.new_bat_created.emit()
