extends Control

@export var level: int

@onready var image: Sprite2D = $Image 
@export var level_image: Texture2D
var nextScene: String
var gameManager: game_manager


func _ready() -> void:
	nextScene = "Level" + str(level)
	print(nextScene)
	$Label.text = str(level)
	image.texture = level_image
	if(Global.levelProgressCount < level-1):
		$"Locked overlay".visible = true

func _on_button_pressed() -> void:
	var tree = get_tree()
	if tree != null:
		await tree.create_timer(.2).timeout
		var gm: game_manager = tree.root.get_node("GameManager")
		if (gm != null):
			gm.LoadNewScene("res://Scenes/Levels/"+nextScene+".tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/Levels/"+nextScene+".tscn")
