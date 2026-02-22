extends Node2D
class_name  game_manager

var currentScene
var mainMenuScene = preload("res://Scenes/MainMenu.tscn")
@export var ScreenFadeManager: Node
var isMainMenu: bool = true

@export var background: Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#currentScene = mainMenuScene.instantiate()
	#$SubViewportContainer.visible = false
	LoadNewScene("res://Scenes/MainMenu.tscn")

func LoadNewScene(name:String):
	if name == "res://Scenes/MainMenu.tscn":
		$SubViewportContainer.visible = false
		background.hide()
	else:
		$SubViewportContainer.visible = true
		background.show()
		
	#$SubViewportContainer/SubViewport.remove_child(currentScene)
	var newScene:PackedScene = load(name)
	if (newScene):
		self.remove_child(currentScene)
		currentScene = newScene.instantiate()
		self.add_child(currentScene)
	#$SubViewportContainer/SubViewport.add_child(currentScene)
	#ScreenFadeManager.fadeOut()
	
