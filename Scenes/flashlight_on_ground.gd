extends Sprite2D


func _on_interactable_component_interacted() -> void:
	print("Testt")
	$"../Player".giveFlashlight()
	self.visible = false
