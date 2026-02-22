extends Area2D

@export var currentScene: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	var sceneManager:game_manager = get_tree().root.get_node("GameManager")
	if (sceneManager != null):
		sceneManager.LoadNewScene("res://Scenes/Levels/"+currentScene+".tscn")
	else:
			get_tree().change_scene_to_file("res://Scenes/Levels/"+currentScene+".tscn")
