class_name BigGuy extends Creature

@onready var anim = $AnimationPlayer
var transitioning : bool = false
var hands : BigGuyHands = null

func _ready():
	super()
	if not transitioning:
		play_anim()
	else:
		anim.play("transition")
	
func animation_finished() -> void:
	if hands != null:
		hands.off()
	GlobalSignal.bigguy_animation_finished.emit(self)
	await get_tree().create_timer(randf_range(15.0, 25.0)).timeout
	play_anim()

# this will pick a random animation
func play_anim() -> void:
	if hands != null:
		hands.on()
	var options = ["peek_1", "peek_2"]
	var random_animation = options.pick_random()
	anim.play(random_animation)
