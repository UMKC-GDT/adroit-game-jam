extends Node2D
class_name SwitchLight

@onready var beam: QuantumLight = $QuantumLight
@export var light_priority = 1

@export var powered = false
@export var starting_light = Global.Timeline.PRESENT

enum LightMode { PRESENT_OR_FUTURE, ON_OFF }
@export var current_mode: LightMode = LightMode.PRESENT_OR_FUTURE

func set_power(state: bool) -> void:
	if powered == state: return
		
	powered = state
	update_state()

func update_state() -> void:
	if not is_node_ready() or beam == null:
		return
	
	# 2. super() just made it solid if it's in the right timeline. 
	# Now, we override those collisions if the switch says the door is open.
	if powered:
		
		if current_mode == LightMode.ON_OFF:
			beam.timeline_type = starting_light
			beam.update_light()
		
		elif current_mode == LightMode.PRESENT_OR_FUTURE:
			if starting_light == Global.Timeline.PRESENT:
				beam.timeline_type = Global.Timeline.FUTURE
				beam.update_light()
			else:
				beam.timeline_type = Global.Timeline.PRESENT
				beam.update_light()
	else:
		if current_mode == LightMode.ON_OFF:
			beam.timeline_type = beam.Timeline.OFF
			beam.update_light()
		elif current_mode == LightMode.PRESENT_OR_FUTURE:
			#THIS LINE
			beam.timeline_type = starting_light
			beam.update_light()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	beam.light_priority = light_priority
	
	update_state()
