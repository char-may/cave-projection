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

var game_controller : GameController
var creature_editing : CreatureType = CreatureType.BAT
