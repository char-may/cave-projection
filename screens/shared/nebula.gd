extends Node2D

@export var rotation_speed = 1.0 # Radians per second
@onready var nebula_sprite = $Sprite2D

@export var scale_to : Vector2
@export var scale_in_time = 2.0
@export var scale_out_time = 1.0

# Nebula will play scale in animation, and after a delay play scale out and destroy itself
# It will always rotate at the set speed

func _ready() -> void:
	# do scale in tween
	var scale_in = create_tween()
	scale_in.tween_property(nebula_sprite,"scale", scale_to, scale_in_time).set_trans(Tween.TRANS_CUBIC)
	await scale_in.finished
	var scale_out = create_tween()
	scale_out.tween_property(nebula_sprite,"scale", Vector2(0,0), scale_out_time).set_trans(Tween.TRANS_CIRC)
	
	# destroy self when tween finished
	await scale_out.finished
	queue_free()
	
func _process(delta):
	# Rotate sprite around its own center
	nebula_sprite.rotation += rotation_speed * delta


   # print("Waiting for 2 seconds...")
   # await get_tree().create_timer(2.0).timeout
   # print("2 seconds have passed!")
