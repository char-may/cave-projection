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

var game_controller : GameController
var creature_editing : CreatureType = CreatureType.BAT
var finished_atlus : ImageTexture = null

# Editor stuff
var selected_tool : ToolType = ToolType.CRAYON
var environment_color = Color("d7d7d7") #does not set color, just a copy of what is in settings
var active_color : Color
var tool_size : int
var background_color : Color
