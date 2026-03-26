class_name Editor extends Node2D

# Editor:
# Exports drawings, loads scene ui and handles transitions

@onready var creature_mask : TextureRect = $CreatureMask

@onready var bat_face_gen : Node2D = $BatFaceGen
@onready var tardigrade_face_gen : Node2D = $TardigradeFaceGen

@export var bat_mask : CompressedTexture2D
@export var tardigrade_mask : CompressedTexture2D
@onready var tardigrade_overlay : TextureRect = $TardigradeOverlay

var background
var export_count = 0

# TODO: Set template/mask based on currently editing creature
# just store all 4 masks as editor properties

func _ready():
	GlobalSignal.finished_drawing.connect(screenshot)
	
	# Add editor UI to game
	Global.game_controller.change_gui_scene("res://screens/drawing_screen/3_editor_screen/editor_ui.tscn", true, false)
	
	background = get_node("Background")
	background.color = Global.background_color
	
	#Set creature mask
	match Global.creature_editing:
		Global.CreatureType.BAT:
			#Do bat stuff
			creature_mask.texture = bat_mask
			bat_face_gen.visible = true
			tardigrade_overlay.visible = false
			tardigrade_face_gen.visible = false
		Global.CreatureType.TARDIGRADE:
			#Do tardigrade stuff
			creature_mask.texture = tardigrade_mask
			tardigrade_face_gen.visible = true
			tardigrade_overlay.visible = true
			bat_face_gen.visible = false
		Global.CreatureType.SALAMANDER:
			#Do salamander stuff
			creature_mask.texture = bat_mask #**** update ******
			bat_face_gen.visible = true
			tardigrade_overlay.visible = false
			tardigrade_face_gen.visible = false
		Global.CreatureType.BIGGUY:
			#Do big guy stuff
			creature_mask.texture = bat_mask
			bat_face_gen.visible = true
			tardigrade_overlay.visible = false
			tardigrade_face_gen.visible = false
	
func screenshot():
	var dir = DirAccess.open("user://")
	
	await RenderingServer.frame_post_draw
	export_count += 1
	
	# Save image to the user directory
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	var path = ""

	match Global.creature_editing:
		Global.CreatureType.BAT:
			#dir.make_dir("exports/bats")
			dir = DirAccess.open("user://exports/bats/")
			export_count = 0
			for n in dir.get_files():
				export_count += 1
			path = "user://exports/bats/export"+str(export_count)+".png"
			print ("Number of files already in bats exports folder: %d" % export_count)
			print(OS.get_data_dir())
		Global.CreatureType.TARDIGRADE:
			#dir.make_dir("exports/tardigrades")
			dir = DirAccess.open("user://exports/tardigrades/")
			export_count = 0
			for n in dir.get_files():
				export_count += 1
			path = "user://exports/tardigrades/export"+str(export_count)+".png"
			print ("Number of files already in tardigrades exports folder: %d" % export_count)
			print(OS.get_data_dir())
		Global.CreatureType.SALAMANDER:
			#dir.make_dir("exports/salamanders")
			dir = DirAccess.open("user://exports/salamanders/")
			for n in dir.get_files():
				export_count += 1
			path = "user://exports/salamanders/export"+str(export_count)+".png"
			print ("Number of files already in salamanders exports folder: %d" % export_count)
			print(OS.get_data_dir())
		Global.CreatureType.BIGGUY:
			#dir.make_dir("exports/bigguys/")
			dir = DirAccess.open("user://exports/bigguys")
			for n in dir.get_files():
				export_count += 1
			path = "user://exports/bigguys/export"+str(export_count)+".png"
			print ("Number of files already in big guys exports folder: %d" % export_count)
			print(OS.get_data_dir())
	
	img.save_png(path)
	
	# Save image texture to global
	var image = Image.new()
	var load_err := image.load(path)
	assert(load_err == OK, "Failed to load image at: ")
	Global.finished_atlus = ImageTexture.create_from_image(image)

func on_set_background_color(color) -> void:
	background = get_node("Background")
	background.color = color
