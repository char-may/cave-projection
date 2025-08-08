class_name CreatureSelectButton extends TextureButton

@export var creature_type : Global.CreatureType
@export var frame_a : Texture2D
@export var frame_b : Texture2D
@export var bat_button : CreatureSelectButton
@export var tardigrade_button : CreatureSelectButton
@export var salamander_button : CreatureSelectButton
@export var monster_button : CreatureSelectButton

@onready var grid = $".."
@onready var confirm_label = $"../../ConfirmLabel"

var current_frame : Texture2D


func _ready() -> void:	
	current_frame = frame_a
	texture_normal = current_frame
	confirm_label.visible = false

func _process(_delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	if current_frame == frame_a:
		current_frame = frame_b
	else:
		current_frame = frame_a
	
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
	tardigrade_button.visible = false
	salamander_button.visible = false
	monster_button.visible = false
	grid_tween()
	grid.columns = 1
	grid_tween()
	
func tardigrade_selected():
	bat_button.visible = false
	salamander_button.visible = false
	monster_button.visible = false
	grid.columns = 1
	grid_tween()

func salamander_selected():
	bat_button.visible = false
	tardigrade_button.visible = false
	monster_button.visible = false
	grid.columns = 1
	grid_tween()

func monster_selected():
	bat_button.visible = false
	tardigrade_button.visible = false
	salamander_button.visible = false
	grid.columns = 1
	grid_tween()

func grid_tween():
	var tween = grid.create_tween()
	tween.tween_property(grid, "rotation_degrees", 360.0, .7).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(.5).timeout
	confirm_label.visible = true
