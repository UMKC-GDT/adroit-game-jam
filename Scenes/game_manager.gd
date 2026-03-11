extends Node2D
class_name  game_manager

@export var background: Sprite2D
@export var ScreenFadeManager: Node
@export var soundManager: SoundManager

var currentScene
var currentSceneName
var mainMenuScene = preload("res://Scenes/MainMenu.tscn")

var isMainMenu: bool = true
var switching := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#currentScene = mainMenuScene.instantiate()
	#$SubViewportContainer.visible = false
	LoadNewScene("res://Scenes/MainMenu.tscn")
	soundManager.play(SoundManager.Emitters.TITLE)

func LevelMusicBegin():
	var tree = get_tree()
	if tree:
		await tree.create_timer(3.5).timeout
		soundManager.play(SoundManager.Emitters.LEVEL)


#func TitleMusicOutie(outieparam: int = 1):
	#$Sprite2D/titleEmitter.set_parameter("TitleOutie", outieparam)
#
#func LevelThreeSection(levelthree: int = 0):
	#$Sprite2D/levelEmitter.set_parameter("Verse1", levelthree)
#
#func LevelTwoOpen(twoopen: int = 0):
	#$Sprite2D/levelEmitter.set_parameter("CutMost", twoopen)
	#
#func DoorSound(dooropen: int = .2):
	#$Sprite2D/doorEmitter.play()
#
#func Pickup(lightpickup: int = .2):
	#$Sprite2D/pickupEmitter.play()
#
#func Pickup2(lightpickup2: int = 0):
	#$Sprite2D/levelEmitter.set_parameter("78Section", lightpickup2)
#
#func Verse2(versetwo: int = 0):
	#$Sprite2D/levelEmitter.set_parameter("Verse2", versetwo)


var thing:bool = true
func LoadNewScene(name:String):
	if(switching):
		return
		
	switching = true
	var newScene:PackedScene = load(name)
	if (newScene):
		if (currentScene):
			if thing:
				thing = false
				self.remove_child(currentScene)
			else:
				$SubViewportContainer/SubViewport.remove_child(currentScene)
		
		currentScene = newScene.instantiate()
		currentSceneName = name

		if name == "res://Scenes/MainMenu.tscn":
			$SubViewportContainer.visible = false
			ScreenFadeManager.visible = false
			background.hide()
			self.add_child(currentScene)
		elif name == "res://Scenes/Levels/credits_scene.tscn":
			$SubViewportContainer.visible = false
			ScreenFadeManager.visible = false
			background.hide()
			self.add_child(currentScene)
		else:
			$SubViewportContainer.visible = true
			ScreenFadeManager.visible = true
			background.show()
			$SubViewportContainer/SubViewport.add_child(currentScene)
		
	#$SubViewportContainer/SubViewport.remove_child(currentScene)

	#$SubViewportContainer/SubViewport.add_child(currentScene)
	switching = false
	ScreenFadeManager.fadeIn()

#Detects if Escape is pressed, exits to main menu if true
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().change_scene_to_file("res://Scenes/GameManager.tscn")
