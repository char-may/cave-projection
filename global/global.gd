extends Node

enum CreatureType {
	BAT,
	TARDIGRADE,
}

enum ToolType {
	PEN,
	ROLLER,
	ERASER
}

var selected_tool : ToolType = ToolType.PEN
var game_controller : GameController
var creature_editing : CreatureType = CreatureType.BAT
var finished_atlus : ImageTexture = null
