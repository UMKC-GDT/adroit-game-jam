extends Node
var gm: game_manager

func _ready() -> void:
	gm = get_tree().root.get_node("GameManager")
	gm.LevelThreeSection(1)
