extends LightObject
class_name DoorSwitch

@export var target_door: SwitchDoor

@onready var future_sprite: AnimatedSprite2D = $FutureSprite
@onready var present_sprite: AnimatedSprite2D = $PresentSprite
@onready var active_sprite: AnimatedSprite2D

var is_switch_on: bool = false

#Note: Most of this is Gemini-written, right now

func _ready() -> void:
	
	if native_timeline == Timeline.FUTURE:
		future_sprite.show()
		active_sprite = future_sprite
		present_sprite.hide()
	else:
		future_sprite.hide()
		present_sprite.show()
		active_sprite = present_sprite
	
	# ALWAYS call super() so the base LightObject code runs on startup
	super()

func _process(delta: float) -> void:
	
	if is_active:
		if is_switch_on:
			active_sprite.frame = 1
		else:
			active_sprite.frame = 0

# Called when the Interacted() signal fires off from the interactable component.
func _on_interactable_component_interacted() -> void:
	
	# You can only flip the switch if it actually exists in reality right now
	if is_active:
		is_switch_on = !is_switch_on
		print("I worked!")
		update_door()

# 3. THE QUANTUM LOGIC
func update_state() -> void:
	# Let the parent LightObject do all the heavy lifting for visibility and physics
	super() 
	
	# The erasure: If it no longer exists, it physically resets to the OFF position
	if not is_active:
		is_switch_on = false
	
	# Every time the light hits it or leaves it, re-evaluate the door
	update_door() 

func update_door() -> void:
	if target_door:
		# The door ONLY opens if the switch is toggled ON and the switch is currently OBSERVED
		target_door.set_open(is_switch_on and is_active)
