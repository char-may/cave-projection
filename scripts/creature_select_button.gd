class_name CreatureSelectButton extends TextureButton

@export var creature_type : Global.CreatureType
@export var frame_a : Texture2D
@export var frame_b : Texture2D
@export var poly1 : Polygon2D
@export var poly2 : Polygon2D
@export var bat_button : CreatureSelectButton
@export var tardigrade_button : CreatureSelectButton
@export var salamander_button : CreatureSelectButton
@export var monster_button : CreatureSelectButton

@onready var grid = $".."
@onready var confirm_label = $"../../ConfirmLabel"
@onready var select_label = $"../../SelectLabel"
@onready var yep_button = $"../../YepButton"
@onready var nope_button = $"../../NopeButton"
var current_frame : Texture2D


func _ready() -> void:	
	pressed.connect(_on_pressed)
	current_frame = frame_a
	texture_normal = current_frame
	confirm_label.visible = false
	select_label.visible = true
	yep_button.visible = false
	nope_button.visible = false

func _process(_delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	if current_frame == frame_a:
		current_frame = frame_b
		poly1.visible = false
		poly2.visible = true
	else:
		current_frame = frame_a
		poly1.visible = true
		poly2.visible = false
	
	texture_normal = current_frame

func _on_pressed() -> void:
	match creature_type:
		Global.CreatureType.BAT:
			bat_selected()
		Global.CreatureType.TARDIGRADE:
			tardigrade_selected()
		Global.CreatureType.SALAMANDER:
			salamander_selected()
		Global.CreatureType.MONSTER:
			monster_selected()

func bat_selected():
	select_label.visible = false
	tardigrade_button.visible = false
	salamander_button.visible = false
	monster_button.visible = false
	grid.columns = 1
	poly1.position = Vector2(320,215)
	poly2.position = Vector2(320,215)
	grid_tween()
	
func tardigrade_selected():
	select_label.visible = false
	bat_button.visible = false
	salamander_button.visible = false
	monster_button.visible = false
	grid.columns = 1
	poly1.position = Vector2(340,215)
	poly2.position = Vector2(340,215)
	grid_tween()

func salamander_selected():
	select_label.visible = false
	bat_button.visible = false
	tardigrade_button.visible = false
	monster_button.visible = false
	grid.columns = 1
	poly1.position = Vector2(315,215)
	poly2.position = Vector2(315,215)
	grid_tween()

func monster_selected():
	select_label.visible = false
	bat_button.visible = false
	tardigrade_button.visible = false
	salamander_button.visible = false
	grid.columns = 1
	poly1.position = Vector2(340,215)
	poly2.position = Vector2(340,215)
	grid_tween()

func grid_tween():
	var tween = grid.create_tween()
	tween.tween_property(grid, "rotation_degrees", 360.0, .7).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(.5).timeout
	confirm_label.visible = true
	yep_button.visible = true
	nope_button.visible = true
	
