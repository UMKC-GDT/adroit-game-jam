extends LightObject
class_name BasicPlatform

@onready var future_sprite: Sprite2D = $FutureSprite
@onready var present_sprite: Sprite2D = $PresentSprite
@onready var invert_sprite: Sprite2D = $InvertSprite

@onready var haze_occluder: PointLight2D = $"Haze Occluder"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if native_timeline == Global.Timeline.FUTURE:
		future_sprite.show()
		present_sprite.hide()
	elif native_timeline == Global.Timeline.OFF:
		invert_sprite.show()
		future_sprite.hide()
		present_sprite.hide()
	else:
		present_sprite.show()
		future_sprite.hide()
		invert_sprite.hide()
		
	
	
	haze_occluder.enabled = true
	print(haze_occluder.enabled)
	
	
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
