extends Node2D
class_name  game_manager

var currentScene: Node
var nextScenePath: String
var loadOnFinish:bool = false
var isFullscreen:bool = true


@export var ScreenFadeManager: Node
@export var background: Sprite2D

var switching := false

var mainMenuScene = preload("res://Scenes/MainMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentScene = mainMenuScene.instantiate()
	self.add_child(currentScene)
	$SubViewportContainer.visible = false
	background.hide()
	$Sprite2D/titleEmitter.play()


func StartLoadingNextScene(name:String, shouldInstantlyLoad:bool):
	nextScenePath = name
	loadOnFinish = shouldInstantlyLoad
	
	var status = ResourceLoader.load_threaded_get_status(name)
	
	if (status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE):
		ResourceLoader.load_threaded_request(name)
		loadOnFinish = shouldInstantlyLoad
	elif status == ResourceLoader.THREAD_LOAD_FAILED:
		ResourceLoader.load_threaded_request(name)
		

func _process(delta: float) -> void:
	if nextScenePath == "":
		return
		
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(nextScenePath, progress)
	if status == ResourceLoader.THREAD_LOAD_LOADED && loadOnFinish:
		loadOnFinish = false
		LoadNewScene(nextScenePath, true)

func LoadNewScene(name:String, loadAsViewport:bool):
	if switching:
		return
	switching = true
	
	# check if the current scene being loaded is done
	var status = ResourceLoader.load_threaded_get_status(nextScenePath)
	
	# if its done loading
	if (status == ResourceLoader.THREAD_LOAD_LOADED):
		#get the loaded thread
		var newSceneResource = ResourceLoader.load_threaded_get(nextScenePath)
		
		if currentScene:
			currentScene.get_parent().remove_child(currentScene)
		currentScene.queue_free()
		
		currentScene = newSceneResource.instantiate()
		
		if loadAsViewport:
			$SubViewportContainer/SubViewport.add_child(currentScene)
			$SubViewportContainer.visible = true
			ScreenFadeManager.visible = true
			background.show()
		else:
			self.add_child(currentScene)
			$SubViewportContainer.visible = false
			ScreenFadeManager.visible = false
			background.hide()
		
		switching = false
		ScreenFadeManager.fadeIn()
	else:
		StartLoadingNextScene(name, true)
		

func TitleMusicOutie(outieparam: int = 1):
	$Sprite2D/titleEmitter.set_parameter("TitleOutie", outieparam)

func LevelMusicBegin(begin: int = .5):
	var tree = get_tree()
	if tree:
		await tree.create_timer(3.5).timeout
		$Sprite2D/levelEmitter.play()
		
func LevelThreeSection(levelthree: int = 0):
	$Sprite2D/levelEmitter.set_parameter("Verse1", levelthree)

func LevelTwoOpen(twoopen: int = 0):
	$Sprite2D/levelEmitter.set_parameter("CutMost", twoopen)
	
func DoorSound(dooropen: int = .2):
	$Sprite2D/doorEmitter.play()

func Pickup(lightpickup: int = .2):
	$Sprite2D/pickupEmitter.play()

func Pickup2(lightpickup2: int = 0):
	$Sprite2D/levelEmitter.set_parameter("78Section", lightpickup2)

func Verse2(versetwo: int = 0):
	$Sprite2D/levelEmitter.set_parameter("Verse2", versetwo)
