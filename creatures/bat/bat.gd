class_name Bat extends Creature
@onready var label = $Container/Label

var label_text: Array = ["!", "?", "hi!", "oh hi!", "I'm a bat!", "Pardon me", "Sup",
"Where are we?", "Nice drawing!", "Have you seen Pete?"]

func _ready():
	super()
	randomize()
	label.visible = false
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_time = rng.randf_range(0.1, 1.0) # wait between 2 and 10 seconds
	var random_text: String = label_text.pick_random()
	await get_tree().create_timer(random_time).timeout
	label.text = random_text
	label.visible = true
	random_time = rng.randf_range(1.0, 3.0) # wait between 2 and 10 seconds
	await get_tree().create_timer(random_time).timeout
	label.visible = false
