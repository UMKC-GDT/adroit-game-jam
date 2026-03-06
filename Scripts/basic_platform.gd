extends LightObject
class_name BasicPlatform

@onready var future_sprite: Sprite2D = $FutureSprite
@onready var present_sprite: Sprite2D = $PresentSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if native_timeline == Global.Timeline.FUTURE:
		future_sprite.show()
		present_sprite.hide()
	else:
		future_sprite.hide()
		present_sprite.show()
	
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
