extends Node2D

var positionVector: Vector2 = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cameraCords = get_viewport().get_mouse_position()
	print("2")
	print(cameraCords)
	positionVector += cameraCords
	self.position = positionVector
	print("1")
	print(self.position)
	pass
	
	
