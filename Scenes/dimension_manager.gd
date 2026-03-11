extends Node2D
class_name DimensionManager

var gm: game_manager
##Handles overlapping the nodes representing both dimensions on top of each other. The left side of the scene is the present, while the right side of the scene is the future. Add elements for either dimension as a child of the PresentLevel and FutureLevel nodes, but keep the player within view of MainCamera -- guide camera is just a guide. Do NOT reposition either nodes. 


@onready var FutureLevel: Node2D = $Future
@onready var PresentLevel: Node2D = $Present

# Called when the node enters the scene tree for the first time. Overlaps both of them on top of each other.
func _ready() -> void:
	gm = get_tree().root.get_node("GameManager")
	FutureLevel.position.x = 0
	PresentLevel.position.x = 0
	
	match name:
		"Level2":
			gm.soundManager.setParameter(SoundManager.Emitters.LEVEL, "Verse1", 1)
		"Level5":
			gm.soundManager.setParameter(SoundManager.Emitters.LEVEL, "Verse2", 1)
			gm.soundManager.setParameter(SoundManager.Emitters.LEVEL, "78Section", 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
