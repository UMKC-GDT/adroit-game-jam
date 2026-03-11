extends Sprite2D
var gm: game_manager

func _on_interactable_component_interacted() -> void:
	print("Testt")
	$"../Player".giveFlashlight()
	self.visible = false
	gm = get_tree().root.get_node("GameManager")
	if gm:
		gm.soundManager.setParameter(SoundManager.Emitters.LEVEL, "78Section", 0)
		gm.soundManager.play(SoundManager.Emitters.PICKUP)
		gm.soundManager.setParameter(SoundManager.Emitters.LEVEL, "Verse1", 0)
