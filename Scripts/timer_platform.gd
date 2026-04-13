extends LightObject
class_name TimerPlatform

@onready var future_sprite: Sprite2D = $FutureSprite
@onready var present_sprite: Sprite2D = $PresentSprite
@onready var invert_sprite: Sprite2D = $InvertSprite
@onready var active_sprite: Sprite2D

@onready var haze_occluder: PointLight2D = $"Haze Occluder"

@export var active_time: float = 5.0
@onready var half_life: float = active_time / 2
@export var invert_decay: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if native_timeline == Global.Timeline.FUTURE:
		future_sprite.show()
		present_sprite.hide()
		
		active_sprite = future_sprite
	elif native_timeline == Global.Timeline.OFF:
		invert_sprite.show()
		future_sprite.hide()
		present_sprite.hide()
		
		active_sprite = invert_sprite
	else:
		present_sprite.show()
		future_sprite.hide()
		invert_sprite.hide()
		
		active_sprite = present_sprite
	
	haze_occluder.enabled = true
	print(haze_occluder.enabled)
	
	print("I exist, starting my timer! Current value:")
	print(active_time)
	
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not invert_decay:
		if is_active:
			active_time -= delta
	elif invert_decay:
		if !is_active:
			active_time -= delta
	
	if active_time <= half_life:
		active_sprite.modulate = Color(0.337, 0.337, 0.337, 1.0)
	
	if active_time <= 0:
		queue_free()
	
	
	pass
