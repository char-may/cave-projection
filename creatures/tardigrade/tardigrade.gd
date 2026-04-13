class_name Tardigrade extends Creature

@onready var circle = $Container/Circle
@onready var circle2 = $Container/Circle2

func _ready():
	super()
	move_speed = 50
	
func _on_boing_timer_timeout() -> void:
	do_circle_tween()
	
func do_circle_tween():
	var circle_tween = create_tween()
	circle_tween.tween_property(circle, "scale", Vector2(1.5, 1.5), .5)
	circle_tween.parallel().tween_property(circle, "self_modulate:a", 0.0, .5)
	circle_tween.tween_callback(reset_circle)
	await get_tree().create_timer(.2).timeout
	
	var circle2_tween = create_tween()
	circle2_tween.tween_property(circle2, "scale", Vector2(1.0, 1.0), .5)
	circle2_tween.parallel().tween_property(circle2, "self_modulate:a", 0.0, .5)
	circle2_tween.tween_callback(reset_circle2)

func reset_circle():
	circle.scale = Vector2(0,0)
	circle.self_modulate.a = 1.0
	
func reset_circle2():
	circle2.scale = Vector2(0,0)
	circle2.self_modulate.a = 1.0
