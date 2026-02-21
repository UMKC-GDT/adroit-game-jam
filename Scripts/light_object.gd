extends RigidBody2D
class_name LightObject

enum Timeline { PRESENT, FUTURE }

@export var native_timeline: Timeline = Timeline.PRESENT

var observer_count = 0
@onready var collision_shape = $CollisionShape2D

# Called when the node enters the scene tree for the first time, and immediately tells it to check if it's being observed at all. If it's not being observed, calling update_state() here should make it immediately just disappear. After all -- if it's not being observed, it doesn't exist!
func _ready() -> void:
	update_state()

func add_observer():
	observer_count += 1
	update_state()

func remove_observer():
	observer_count -= 1
	observer_count = max(0, observer_count)
	
	update_state()

func update_state():
	var is_active = observer_count > 0
	
	#Using is_active as a boolean, we decide -- if it's active and observed by more than one light, then exist! Otherwise, don't.
	visible = is_active
	freeze = !is_active
	collision_shape.set_deferred("disabled", !is_active)
