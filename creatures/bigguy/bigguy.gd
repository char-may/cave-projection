class_name  BigGuy extends Creature

@onready var anim = $AnimationPlayer
var transitioning : bool = false

func _ready():
	super()
	if not transitioning:
		anim.play("peek_1") # will later select a random animation
	
func animation_finished() -> void:
	print("Big guy animation finished")
