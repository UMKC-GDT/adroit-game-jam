extends LightObject
class_name SuperWall

@onready var future_sprite: Node2D = $FutureSprite
@onready var present_sprite: Node2D = $PresentSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if native_timeline == Timeline.FUTURE:
		future_sprite.show()
		present_sprite.hide()
	else:
		future_sprite.hide()
		present_sprite.show()
	
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
