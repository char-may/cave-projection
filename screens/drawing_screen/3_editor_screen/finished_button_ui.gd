extends TextureButton

@onready var ok_label = $OKLabel
@onready var all_done_label = $AllDoneLabel

func _ready() -> void:
	ok_label.visible = true
	all_done_label.visible = false

func _on_pressed() -> void:
	if ok_label.text == "Yep!":
		pass
	else:
		all_done_label.visible = true
		ok_label.text = "Yep!"
		ok_label.position.x = ok_label.position.x - 15
