extends RigidBody2D
class_name LightObject

enum Timeline { PRESENT, FUTURE }

@export var native_timeline: Timeline = Timeline.PRESENT

var same_timeline_observers: int = 0
var opposing_timeline_observers: int = 0

var is_active: bool
@onready var collision_shape = $CollisionShape2D

var stored_linear_vel: Vector2 = Vector2.ZERO
var stored_angular_vel: float = 0.0
var was_active: bool = true # Tracks the previous state

# Called when the node enters the scene tree for the first time, and immediately tells it to check if it's being observed at all. If it's not being observed, calling update_state() here should make it immediately just disappear. After all -- if it's not being observed, it doesn't exist!
func _ready() -> void:
	update_state()

func add_observer(is_match: bool):
	if is_match:
		same_timeline_observers += 1
	else:
		opposing_timeline_observers += 1
	update_state()

func remove_observer(is_match: bool):
	if is_match:
		same_timeline_observers -= 1
	else:
		opposing_timeline_observers -= 1
	
	same_timeline_observers = max(0, same_timeline_observers)
	opposing_timeline_observers = max(0, opposing_timeline_observers)
	update_state()

func update_state():
	# NEW LOGIC: To exist, you must be seen by your OWN timeline 
	# AND NOT be seen by the OPPOSING timeline.
	is_active = (same_timeline_observers > 0) and (opposing_timeline_observers == 0)
	
	# If it's turning OFF, cache the momentum right now before it freezes
	if was_active and not is_active:
		stored_linear_vel = linear_velocity
		stored_angular_vel = angular_velocity
	
	visible = is_active
	
	set_deferred("freeze", !is_active)
	if is_active:
		set_deferred("sleeping", false)
		
	# Decide which layer this object belongs to (3 for Present, 4 for Future)
	var physics_layer = 3 if native_timeline == Timeline.PRESENT else 4
	
	# Turn on/off its specific timeline layer
	call_deferred("set_collision_layer_value", physics_layer, is_active)
	call_deferred("set_collision_mask_value", physics_layer, is_active)
	
	# Always toggle collision with the World (Layer 1) so it doesn't fall through the floor
	call_deferred("set_collision_mask_value", 1, is_active)

	# If it's turning back ON, restore the momentum safely after the unfreeze
	if not was_active and is_active:
		call_deferred("_restore_momentum")
		
	# Update the tracker for the next time this runs
	was_active = is_active

func _restore_momentum():
	# Forcing the velocity back into the RigidBody
	linear_velocity = stored_linear_vel
	angular_velocity = stored_angular_vel
