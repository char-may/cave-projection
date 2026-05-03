class_name WelcomeBat extends Creature
@onready var label = $Container/Label

@onready var timer : Timer = $Timer
var is_cancelled : bool = false

func _ready():
	super()
	move_speed = 25
	label.visible = false
	GlobalSignal.new_bat_created.connect(thank_you)
	GlobalSignal.new_tardigrade_created.connect(thank_you)
	GlobalSignal.new_bigguy_created.connect(thank_you)
	GlobalSignal.new_salamander_created.connect(thank_you)
	welcome_dialog()
	
func welcome_dialog():
	is_cancelled = false
	await get_tree().create_timer(3).timeout
	if is_cancelled: return # Check here
	
	label.visible = true
	label.text = "Ahem... *clears throat*"
	await get_tree().create_timer(3).timeout
	if is_cancelled: return # Check here
	
	label.text = ""
	await get_tree().create_timer(1).timeout
	if is_cancelled: return # Check here
	
	label.text = "Hello!"
	await get_tree().create_timer(3).timeout
	if is_cancelled: return # Check here
	
	label.text = ""
	await get_tree().create_timer(1).timeout
	if is_cancelled: return # Check here
	
	label.text = "My name is Welcome Bat."
	await get_tree().create_timer(3).timeout
	if is_cancelled: return # Check here
	
	label.text = ""
	await get_tree().create_timer(1).timeout
	if is_cancelled: return # Check here
	
	label.text = "Welcome to Light's Out!"
	await get_tree().create_timer(3).timeout
	if is_cancelled: return # Check here
	
	label.text = ""
	await get_tree().create_timer(1).timeout
	if is_cancelled: return # Check here
	
	label.text = "It's very quiet in here."
	await get_tree().create_timer(3).timeout
	if is_cancelled: return # Check here
	
	label.text = ""
	await get_tree().create_timer(1).timeout

	label.text = "Will you draw some friends for me?"
	await get_tree().create_timer(3).timeout
	if is_cancelled: return # Check here
	
	label.text = ""
	await get_tree().create_timer(1).timeout
	if is_cancelled: return # Check here
	
	label.text = "You can make different creatures!"
	await get_tree().create_timer(3).timeout
	if is_cancelled: return # Check here
	
	label.text = ""
	await get_tree().create_timer(1).timeout
	if is_cancelled: return # Check here
	
	label.text = "Try it now, on the drawing screen!"
	await get_tree().create_timer(3).timeout
	if is_cancelled: return # Check here
	
	label.text = ""
	await get_tree().create_timer(1).timeout
	if is_cancelled: return # Check here
	
	label.text = "Let's see how many we can make!"
	await get_tree().create_timer(3).timeout
	if is_cancelled: return # Check here
	label.text = ""
	if is_cancelled: return # Check here
	label.visible = false
	if is_cancelled: return # Check here
	timer.start(30.0)

func thank_you() -> void:
	is_cancelled = true
	timer.stop()
	label.visible
	label.text = ""
	await get_tree().create_timer(3).timeout
	label.text = "Oh, a new creature!"
	await get_tree().create_timer(3).timeout
	label.text = ""
	await get_tree().create_timer(1).timeout
	label.text = "Thank you!"
	await get_tree().create_timer(3).timeout
	label.text = ""
	await get_tree().create_timer(1).timeout
	label.text = "You did so well!"
	await get_tree().create_timer(3).timeout
	label.text = ""
	await get_tree().create_timer(1).timeout
	label.text = "I'll let you take it from here!"
	await get_tree().create_timer(3).timeout
	label.text = ""
	await get_tree().create_timer(1).timeout
	
	# do puff and destroy
	var container = get_node("Container")
	var puff_instance = Global.PUFF.instantiate()
	puff_instance.position = container.position
	puff_instance.scale = Vector2(10.0, 10.0)
	add_child(puff_instance)
	GlobalSignal.do_puff.emit()
	container.visible = false
	await get_tree().create_timer(3.0).timeout
	self.queue_free()
	
func _on_timer_timeout() -> void:
	timer.stop()
	welcome_dialog()
