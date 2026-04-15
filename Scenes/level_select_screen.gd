extends Node2D

var isVisible = false
@export var unlockedLevels: int

func _ready() -> void:
	visible = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("level select"):
		visible = !isVisible
		isVisible = visible
