extends Node2D
var isOn: bool = true #Always starts on
var gm: game_manager

var onTexture = load("res://Resources/OrangeLeverUp.png")
var offTexture = load("res://Resources/BlueLeverDown.png")
signal turnedOff()
signal turnedOn() 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_component_interacted() -> void:
	$switchEmitter.play()
	gm = get_tree().root.get_node("GameManager")
	gm.LevelTwoOpen(0)
	isOn = !isOn
	if isOn: #Just turned on by the function
		$Sprite2D.texture = onTexture
		turnedOn.emit()
	else: #Just turned off by the function
		$Sprite2D.texture = offTexture
		turnedOff.emit()
