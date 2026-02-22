extends QuantumLight
class_name SimpleFlashlight

##Probably gonna be used more for debug than anything, but this turns a quantum light into a simple flashlight that follows the mouse.

@export var flashlight_radius = 20
@export var starting_light: Timeline = Timeline.PRESENT
@onready var circle: CollisionShape2D = $Circle

# Variables for Controller Support (Done By Trevor N)
var stickDirection
var lastMousePosition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	circle.shape.radius = flashlight_radius
	
	timeline_type = starting_light
	
	if timeline_type == Timeline.FUTURE:
		light_sprite.modulate = future_color
		
	else:
		light_sprite.modulate = present_color
	lastMousePosition = get_global_mouse_position()

func set_starting_light(present_light):
	
	print("FLASHLIGHT: " + str(present_light))
	
	if present_light:
		starting_light = Timeline.PRESENT
	else:
		starting_light = Timeline.FUTURE
	
	timeline_type = starting_light
	
	if timeline_type == Timeline.FUTURE:
		light_sprite.modulate = future_color
		
	else:
		light_sprite.modulate = present_color
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	stickDirection = Input.get_vector("rightStickLeft", "rightStickRight", "rightStickUp", "rightStickDown")
	if (get_global_mouse_position() != lastMousePosition):
		look_at(get_global_mouse_position())
		lastMousePosition = get_global_mouse_position()
	else:
		look_at($".".global_position + stickDirection)

func _unhandled_input(event): # Listen for a standard Left Mouse Click
	if event.is_action_pressed("lightToggle"):
		swap_timeline()

func swap_timeline() -> void:
	# Flip the timeline
	timeline_type = Timeline.FUTURE if timeline_type == Timeline.PRESENT else Timeline.PRESENT
	print(name + " swapping! Current: " + Timeline.keys()[timeline_type])
	
	update_light()

func getRotation():
	return abs(fmod(self.rotation_degrees, 360))/2
