extends Node2D
class_name  game_manager

var currentScene
var myScene = preload("res://Scenes/MainMenu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentScene = myScene.instantiate()
	add_child(currentScene)
	pass # Replace with function body.

func LoadNewScene(name:String):
	remove_child(currentScene)
	var newScene:PackedScene = load(name)
	currentScene = newScene.instantiate()
	add_child(currentScene)
