extends LightObject
class_name DoorSwitch

@export var target_door: SwitchDoor

var is_switch_on: bool = false

#Note: Most of this is Gemini-written, right now

func _ready() -> void:
	# ALWAYS call super() so the base LightObject code runs on startup
	super()

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
