extends Node
@onready var bat_ui : Node2D = $BatUI
@onready var tardigrade_ui : Node2D = $TardigradeUI

func _ready() -> void:
	match Global.creature_editing:
		Global.CreatureType.BAT:
			bat_ui.visible = true
			tardigrade_ui.visible = false
		Global.CreatureType.TARDIGRADE:
			bat_ui.visible = false
			tardigrade_ui.visible = true
		Global.CreatureType.SALAMANDER:
			bat_ui.visible = false
			tardigrade_ui.visible = false
		Global.CreatureType.MONSTER:
			bat_ui.visible = false
			tardigrade_ui.visible = false
