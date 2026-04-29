class_name Bat extends Creature
@onready var label = $Container/Label

var yap_text: Array = [
	"!",
	"?",
	"!!",
	"..."]

var talking : bool = false
var rng #random number generator

func _ready():
	super()
	move_speed = 25
	rng = RandomNumberGenerator.new()
	rng.randomize()
	label.visible = false
	
func _on_area_2d_area_entered(_area: Area2D) -> void:
	if !talking:
		talking = true
		var random_time = rng.randf_range(0.1, .5)
		var random_yap: String = yap_text.pick_random()
		await get_tree().create_timer(random_time).timeout
		label.text = random_yap
		label.visible = true
		random_time = rng.randf_range(1.0, 3.0)
		await get_tree().create_timer(random_time).timeout
		label.visible = false
		talking = false
