extends Node2D
class_name  game_manager

var currentScene
var mainMenuScene = preload("res://Scenes/MainMenu.tscn")
@export var ScreenFadeManager: Node
var isMainMenu: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentScene = mainMenuScene.instantiate()
	$SubViewportContainer.visible = false
	LoadNewScene("res://Scenes/Levels/Level2.tscn")

func LoadNewScene(name:String):
	
	if name == "res://Scenes/MainMenu.tscn":
		$SubViewportContainer.visible = false
	else:
		$SubViewportContainer.visible = true
	$SubViewportContainer/SubViewport.remove_child(currentScene)
	var newScene:PackedScene = load(name)
	currentScene = newScene.instantiate()
	$SubViewportContainer/SubViewport.add_child(currentScene)
	#ScreenFadeManager.fadeOut()
