extends Area2D
class_name QuantumLight

enum Timeline { PRESENT, FUTURE }

@export var timeline_type: Timeline = Timeline.PRESENT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#await get_tree().process_frame
	#for body in get_overlapping_bodies():
	#	_on_body_entered(body)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	# Listen for a standard Left Mouse Click
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		swap_timeline()

func _on_body_entered(body: Node2D) -> void:
	if body is LightObject:
		# Tell the body if this light matches its native timeline
		var is_match = (body.native_timeline == self.timeline_type)
		body.add_observer(is_match)

func _on_body_exited(body: Node2D) -> void:
	if body is LightObject:
		var is_match = (body.native_timeline == self.timeline_type)
		body.remove_observer(is_match)

func swap_timeline() -> void:
	# Purge all current overlaps before swapping to prevent ghost counts
	for body in get_overlapping_bodies():
		if body is LightObject:
			_on_body_exited(body)
			
	# Flip the enum
	timeline_type = Timeline.FUTURE if timeline_type == Timeline.PRESENT else Timeline.PRESENT
	print(name + "Swapping! Current: " + Timeline.keys()[timeline_type])
	
	# Re-check everything in the beam with the new timeline setting
	for body in get_overlapping_bodies():
		if body is LightObject:
			_on_body_entered(body)
