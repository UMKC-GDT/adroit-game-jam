extends Node2D
class_name  game_manager

var currentScene
var currentSceneName
var mainMenuScene = preload("res://Scenes/MainMenu.tscn")
@export var ScreenFadeManager: Node
var isMainMenu: bool = true

@export var background: Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#currentScene = mainMenuScene.instantiate()
	#$SubViewportContainer.visible = false
	LoadNewScene("res://Scenes/MainMenu.tscn")

var thing:bool = true
func LoadNewScene(name:String):
	var newScene:PackedScene = load(name)
	if (newScene):
		if (currentScene):
			if thing:
				thing= false
				self.remove_child(currentScene)
			else:
				$SubViewportContainer/SubViewport.remove_child(currentScene)
		
		currentScene = newScene.instantiate()
		currentSceneName = name

		if name == "res://Scenes/MainMenu.tscn":
			$SubViewportContainer.visible = false
			background.hide()
			self.add_child(currentScene)
			
		else:
			$SubViewportContainer.visible = true
			background.show()
			$SubViewportContainer/SubViewport.add_child(currentScene)
		
	#$SubViewportContainer/SubViewport.remove_child(currentScene)

	#$SubViewportContainer/SubViewport.add_child(currentScene)
	#ScreenFadeManager.fadeOut()
	
