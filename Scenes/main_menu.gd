extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	var sceneManager:game_manager = find_parent("GameManager")
	if (sceneManager != null):
		sceneManager.LoadNewScene("res://Scenes/Levels/Level1.tscn")
	else:
<<<<<<< Updated upstream
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")
=======
		get_tree().change_scene_to_file("res://Scenes/Levels/Level11.tscn")
>>>>>>> Stashed changes


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
