extends Node2D
class_name DimensionManager

##Handles overlapping the nodes representing both dimensions on top of each other


@onready var FutureLevel: Node2D = $Future
@onready var PresentLevel: Node2D = $Present

# Called when the node enters the scene tree for the first time. Overlaps both of them on top of each other.
func _ready() -> void:
	print("Doing your mom!")
	FutureLevel.position.x = 0
	PresentLevel.position.x = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
