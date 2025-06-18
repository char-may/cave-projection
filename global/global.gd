extends Node

enum CreatureType {
	BAT,
	TARDIGRADE,
	SALAMANDER,
	MONSTER
}

enum ToolType {
	CRAYON,
	BRUSH,
	ERASER
}

var selected_tool : ToolType = ToolType.CRAYON
var game_controller : GameController
var creature_editing : CreatureType = CreatureType.BAT
var finished_atlus : ImageTexture = null
