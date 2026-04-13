extends Control

@export var level = 1
@export var nextScene: String
@export var gameManager: game_manager

func _ready() -> void:
	$Label.text = str(level)
	$Image.texture = load("res://Resources/levelselect images/"+nextScene+"Image.png")

func _on_button_pressed() -> void:
	var tree = get_tree()
	if tree != null:
		await tree.create_timer(.2).timeout
		var gm: game_manager = tree.root.get_node("GameManager")
		if (gm != null):
			gm.LoadNewScene("res://Scenes/Levels/"+nextScene+".tscn")
		else:
				get_tree().change_scene_to_file("res://Scenes/Levels/"+nextScene+".tscn")
