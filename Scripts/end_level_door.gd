extends Node2D
@export var canOpen: bool
@export var nextScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if nextScene == null:
		push_error("EndLevelDoor has no nextScene!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_component_interacted() -> void:
	pass # Replace with function body.
