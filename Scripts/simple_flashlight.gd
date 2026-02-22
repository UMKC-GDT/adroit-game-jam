extends QuantumLight
class_name SimpleFlashlight

##Probably gonna be used more for debug than anything, but this turns a quantum light into a simple flashlight that follows the mouse.

@export var flashlight_radius = 20
@export var starting_light: Timeline = Timeline.PRESENT
@onready var circle: CollisionShape2D = $Circle

# NEW: Track the active aiming device
var is_using_mouse: bool = true

# Variables for Controller Support (Done By Trevor N)
var stickDirection
var lastMousePosition


var lastUsedLight: Timeline = Timeline.OFF

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	circle.shape.radius = flashlight_radius
	
	timeline_type = starting_light
	
	if timeline_type == Timeline.FUTURE:
		light_sprite.modulate = future_color
	
	elif timeline_type == Timeline.PRESENT:
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
	elif timeline_type == Timeline.PRESENT:
		light_sprite.modulate = present_color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var stickDirection = Input.get_vector("rightStickLeft", "rightStickRight", "rightStickUp", "rightStickDown")
	
	# If the stick is tilted past a tiny deadzone, lock into controller mode
	if stickDirection.length() > 0.1:
		is_using_mouse = false
		
	# Execute the aiming logic based on whatever mode we are currently locked into
	if is_using_mouse:
		# Always look at the mouse, even if it's sitting perfectly still. 
		# If the player walks forward, the flashlight will dynamically track that global coordinate.
		look_at(get_global_mouse_position())
	else:
		# Only update the rotation if they are actively pushing the stick.
		# If they let go (stick length is 0), it just stays pointing exactly where they left it.
		if stickDirection.length() > 0.1:
			look_at(global_position + stickDirection)

func _input(event: InputEvent) -> void:
	# If they bump the mouse or click, instantly lock into mouse mode
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		is_using_mouse = true

func _unhandled_input(event): # Listen for a standard Left Mouse Click
	if event.is_action_pressed("lightToggle"):
		swap_timeline()

func swap_timeline() -> void:
	if timeline_type == Timeline.OFF: # do nothin of its off
		return
	# Flip the timeline
	timeline_type = Timeline.FUTURE if timeline_type == Timeline.PRESENT else Timeline.PRESENT
	print(name + " swapping! Current: " + Timeline.keys()[timeline_type])
	
	print("Calling update light!")
	update_light()

func getRotation():
	return abs(fmod(self.rotation_degrees, 360))/2

func toggleLight(state: bool):
	$LightBeam.visible = state
	$PointLight2D/LightOccluder2D.visible = state
	var tempState := timeline_type
	timeline_type = lastUsedLight
	lastUsedLight = tempState
	
	update_light()
