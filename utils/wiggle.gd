extends Node2D

@export var frequency: float = 4.0   # How many "wiggles" per second
@export var amplitude: float = 30.0  # Max distance from the original position
@export var active: bool = false

var noise := FastNoiseLite.new()
var noise_offset_x: float = 0.0
var noise_offset_y: float = 0.0
var initial_position: Vector2

func _ready():
	initial_position = position
	
	# Initialize the FastNoiseLite object
	noise.seed = randi() # A random seed ensures a new pattern each time
	
	# Randomize the starting noise offset for variation
	noise_offset_x = randf() * 1000
	noise_offset_y = randf() * 1000

func _process(delta):
	if active:
		# Calculate the new noise offsets based on time and frequency
		noise_offset_x += delta * frequency
		noise_offset_y += delta * frequency
		# Sample the noise function to get smooth random values between -1 and 1
		var noise_x = noise.get_noise_1d(noise_offset_x)
		var noise_y = noise.get_noise_1d(noise_offset_y)
		# Use the noise values to offset the position
		position.x = initial_position.x + (noise_x * amplitude)
		position.y = initial_position.y + (noise_y * amplitude)
