class_name Tardigrade extends Creature

var rng #random number generator

func _ready():
	super()
	move_speed = 60
	rng = RandomNumberGenerator.new()
	rng.randomize()
