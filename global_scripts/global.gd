extends Node

enum CreatureType {
	BAT,
	TARDIGRADE,
	SALAMANDER,
	BIGGUY
}

enum ToolType {
	CRAYON,
	BRUSH,
	ERASER
}

var game_controller : GameController
var is_first_run = true # used in game controller to see if reset or first run, for file cleanup

# Editor stuff
var creature_editing : CreatureType = CreatureType.BAT
var finished_atlus : ImageTexture = null
var selected_tool : ToolType = ToolType.CRAYON
var active_color : Color
var tool_size : int
var background_color : Color = "2f589e"

func get_drawing_color() -> Color:
	if selected_tool == ToolType.ERASER:
		return background_color
	else:
		return active_color
