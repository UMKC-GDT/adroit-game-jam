extends QuantumLight
class_name SimpleFlashlight

##Probably gonna be used more for debug than anything, but this turns a quantum light into a simple flashlight that follows the mouse.

@export var flashlight_radius = 20
@onready var circle: CollisionShape2D = $Circle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	circle.shape.radius = flashlight_radius
	
	if timeline_type == Timeline.FUTURE:
		light_sprite.modulate = future_color
		
	else:
		light_sprite.modulate = present_color
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

func _input(event: InputEvent) -> void:
	# Listen for a standard Left Mouse Click
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		swap_timeline()

func swap_timeline() -> void:
	# Flip the timeline
	timeline_type = Timeline.FUTURE if timeline_type == Timeline.PRESENT else Timeline.PRESENT
	print(name + " swapping! Current: " + Timeline.keys()[timeline_type])
	
	if timeline_type == Timeline.FUTURE:
		print("Setting color to blue!")
		light_sprite.modulate = future_color
		
	else:
		print("Setting color to orange!")
		light_sprite.modulate = present_color
	
	# Just poke the objects and tell them to look at your new color
	for body in get_overlapping_bodies():
		if body is LightObject:
			body.update_state()

func getRotation():
	return abs(fmod(self.rotation_degrees, 360))/2
