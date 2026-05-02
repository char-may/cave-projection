extends PathFollow2D

@export var timer : Timer
@onready var salamander = $Salamander
var speed = 0.1
var walking : bool = false
var anim

func _ready() -> void:
	walking = true
	anim = salamander.get_node("AnimationPlayer")
	start_random_timer()

func start_random_timer():
	if timer != null:
		timer.wait_time = randf_range(0.5, 3.0)
		timer.start()
	
func _process(delta) -> void:
	if walking:
		progress_ratio += delta * speed
		
func _on_timer_1_timeout() -> void:
	if walking:
		walking = false
		anim.stop()
		start_random_timer()
	else:
		walking = true
		anim.play()
		start_random_timer()
func _on_timer_2_timeout() -> void:
	if walking:
		walking = false
		anim.stop()
		start_random_timer()
	else:
		walking = true
		anim.play()
		start_random_timer()
func _on_timer_3_timeout() -> void:
	if walking:
		walking = false
		anim.stop()
		start_random_timer()
	else:
		walking = true
		anim.play()
		start_random_timer()
func _on_timer_4_timeout() -> void:
	if walking:
		walking = false
		anim.stop()
		start_random_timer()
	else:
		walking = true
		anim.play()
		start_random_timer()
