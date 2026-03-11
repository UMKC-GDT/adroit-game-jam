extends Node2D

var gm: game_manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gm = get_tree().root.get_node("GameManager")

func _on_start_pressed() -> void:
	gm.soundManager.setParameter(SoundManager.Emitters.TITLE, "TitleOutie", 1)
	var sceneManager:game_manager = find_parent("GameManager")
	if (sceneManager != null):
		sceneManager.LoadNewScene("res://Scenes/Levels/Level1 (New).tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1 (New).tscn")



func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	gm.LoadNewScene("res://Scenes/Levels/credits_scene.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
