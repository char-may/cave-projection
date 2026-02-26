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
	# Add editor UI to game
	Global.game_controller.change_gui_scene("res://screens/drawing_screen/3_editor_screen/editor_ui.tscn", true, false)
	
	background = get_node("Background")
	background.color = Global.background_color
	
	# Create export directory
	var dir = DirAccess.open("user://")
	
	#Set creature mask
	match Global.creature_editing:
		Global.CreatureType.BAT:
			#Do bat stuff
			dir.make_dir("exports/bats")
			dir = DirAccess.open("user://exports/bats/")
			creature_mask.texture = bat_mask
			bat_face_gen.visible = true
			tardigrade_overlay.visible = false
			tardigrade_face_gen.visible = false
		Global.CreatureType.TARDIGRADE:
			#Do tardigrade stuff
			dir.make_dir("exports/tardigrades")
			dir = DirAccess.open("user://exports/tardigrades/")
			creature_mask.texture = tardigrade_mask
			tardigrade_face_gen.visible = true
			tardigrade_overlay.visible = true
			bat_face_gen.visible = false
		Global.CreatureType.SALAMANDER:
			#Do bat stuff
			dir.make_dir("exports/bats")
			dir = DirAccess.open("user://exports/bats/")
			creature_mask.texture = bat_mask
			bat_face_gen.visible = true
			tardigrade_overlay.visible = false
			tardigrade_face_gen.visible = false
		Global.CreatureType.MONSTER:
			#Do bat stuff
			dir.make_dir("exports/bats/")
			dir = DirAccess.open("user://exports/bats")
			creature_mask.texture = bat_mask
			bat_face_gen.visible = true
			tardigrade_overlay.visible = false
			tardigrade_face_gen.visible = false

	# Set counter to the current number of files
	for n in dir.get_files():
		export_count += 1

	print ("Number of files already in exports folder: %d" % export_count)
	print(OS.get_data_dir())
	
	
func _input(event):
	# TODO Change this action to something like "export" when UI is finished
	if event.is_action_pressed("screenshot"):
		screenshot()
	
func screenshot():
	await RenderingServer.frame_post_draw
	export_count += 1
	
	# Save image to the user directory
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	var path = ""
	match Global.creature_editing:
		Global.CreatureType.BAT:
			path = "user://exports/bats/export"+str(export_count)+".png"
		Global.CreatureType.TARDIGRADE:
			path = "user://exports/tardigrades/export"+str(export_count)+".png"
		Global.CreatureType.SALAMANDER:
			path = "user://exports/bats/export"+str(export_count)+".png"
		Global.CreatureType.MONSTER:
			path = "user://exports/bats/export"+str(export_count)+".png"

	img.save_png(path)
	
	# Save image texture to global
	var image = Image.new()
	var load_err := image.load(path)
	assert(load_err == OK, "Failed to load image at: ")
	Global.finished_atlus = ImageTexture.create_from_image(image)
	
	Global.game_controller.change_2d_scene("res://screens/drawing_screen/1_splash_screen/splash_screen_manager.tscn", true, false)
	Global.game_controller.change_gui_scene("res://screens/empty_gui.tscn", true, false)
	
	match Global.creature_editing:
		Global.CreatureType.BAT:
			GlobalSignal.new_bat_created.emit()
		Global.CreatureType.TARDIGRADE:
			GlobalSignal.new_tardigrade_created.emit()
		Global.CreatureType.SALAMANDER:
			GlobalSignal.new_bat_created.emit()
		Global.CreatureType.MONSTER:
			GlobalSignal.new_bat_created.emit()
			
func on_set_background_color(color) -> void:
	background = get_node("Background")
	background.color = color
