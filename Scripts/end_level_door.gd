extends LightObject
class_name EndLevelDoor

@export var canOpen: bool
@export var nextScene: PackedScene

@onready var future_sprite: AnimatedSprite2D = $FutureSprite
@onready var present_sprite: AnimatedSprite2D = $PresentSprite
@onready var active_sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print("Checking for which is which!")
	
	if native_timeline == Timeline.FUTURE:
		future_sprite.show()
		active_sprite = future_sprite
		print("My active sprite:" + str(present_sprite.name))
		
		present_sprite.hide()
	else:
		future_sprite.hide()
		
		present_sprite.show()
		active_sprite = present_sprite
		print("My active sprite:" + str(present_sprite.name))

	if nextScene == null:
		push_error("EndLevelDoor has no nextScene!")
		active_sprite.play("Closed")
	
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_interactable_component_interacted() -> void:
	print("Test animation")
	$AnimatedSprite2D.play("OpenDoor")
	await get_tree().create_timer(.3).timeout
	$AnimatedSprite2D.play("Opened")
	
