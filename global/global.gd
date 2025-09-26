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
	ERASER,
	EYE_STAMP
}

var game_controller : GameController

# Editor stuff
var creature_editing : CreatureType = CreatureType.BAT
var finished_atlus : ImageTexture = null
var selected_tool : ToolType = ToolType.CRAYON
var active_color : Color
var tool_size : int
var background_color : Color = "2f589e" #set via palette and load palette in editor not drawing tools
#1f2757
func get_drawing_color() -> Color:
	if selected_tool == ToolType.ERASER:
		return background_color
	else:
		return active_color
