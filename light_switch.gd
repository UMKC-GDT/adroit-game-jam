extends Node2D
var isOn: bool = true #Always starts on

var onTexture = load("res://Resources/Onswitch.png")
var offTexture = load("res://Resources/OffSwitch.png")
signal turnedOff()
signal turnedOn() 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_component_interacted() -> void:
	isOn = !isOn
	if isOn: #Just turned on by the function
		$Sprite2D.texture = onTexture
		turnedOn.emit()
	else: #Just turned off by the function
		$Sprite2D.texture = offTexture
		turnedOff.emit()
