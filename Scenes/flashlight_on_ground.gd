extends Sprite2D
var gm: game_manager

func _on_interactable_component_interacted() -> void:
	print("Testt")
	$"../Player".giveFlashlight()
	self.visible = false
	gm = get_tree().root.get_node("GameManager")
	gm.Pickup2(1)
	gm.Pickup()
	gm.LevelThreeSection(0)
