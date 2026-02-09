extends Node2D

@export var frequency: float = 5.0   # How many "wiggles" per second
@export var target_amplitude: float = 800.0  # Max distance from the original position

var amplitude = 0.0

var noise := FastNoiseLite.new()
var noise_offset_x: float = 0.0
var noise_offset_y: float = 0.0
var initial_position: Vector2

# Animation stuff
# var tween_time : float = 1
# var transition_type : Tween.TransitionType

func _ready():
	initial_position = position
	
	#start tween amplitude from 0 to target
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'amplitude', target_amplitude, 2).set_trans(Tween.TRANS_SINE)
	
	# Initialize the FastNoiseLite object
	noise.seed = randi() # A random seed ensures a new pattern each time
	
	# Randomize the starting noise offset for variation
	noise_offset_x = randf() * 1000
	noise_offset_y = randf() * 1000

func _process(delta):
	# Calculate the new noise offsets based on time and frequency
	noise_offset_x += delta * frequency
	noise_offset_y += delta * frequency
	# Sample the noise function to get smooth random values between -1 and 1
	var noise_x = noise.get_noise_1d(noise_offset_x)
	var noise_y = noise.get_noise_1d(noise_offset_y)
	# Use the noise values to offset the position
	position.x = initial_position.x + (noise_x * amplitude)
	position.y = initial_position.y + (noise_y * amplitude)
