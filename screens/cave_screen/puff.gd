extends Node2D

@onready var puff = $CPUParticles2D

func _ready() -> void:
	GlobalSignal.do_puff.connect(do_puff)

func do_puff() -> void:
	puff.emitting = true
