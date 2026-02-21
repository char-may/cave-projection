extends Label

func _process(_delta: float) -> void:
	self.text = str(get_owner().scale) + str($"../Container".scale)
