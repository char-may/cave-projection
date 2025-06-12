extends Node

enum CreatureType {
	BAT,
	TARDIGRADE,
}

var game_controller : GameController
var creature_editing : CreatureType = CreatureType.BAT
var atlas_texture : CompressedTexture2D
