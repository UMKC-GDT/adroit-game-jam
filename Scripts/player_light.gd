extends Node2D
class_name PlayerLight

## Expanded version of simple flashlight to allow more sources

@export var auraRadius = 20
@export var lightPriority := 50
@export var starting_light: Global.Timeline = Global.Timeline.PRESENT
@export var AdditionLightAreas: Array[QuantumLight]

@onready var circle: CollisionShape2D = $PlayerAura/Circle
@onready var flashlightArea: Area2D = $LightArea
@onready var lightingAreas: Array[QuantumLight] = [$LightArea, $PlayerAura, $floorLighter]


# NEW: Track the active aiming device
var is_using_mouse: bool = true
# Variables for Controller Support (Done By Trevor N)
var stickDirection
var lastMousePosition
#
var lastUsedLight: Global.Timeline = Global.Timeline.OFF
var timeline_type = Global.Timeline.PRESENT


func _ready() -> void:
	# add any aditions sources to the array
	for light in AdditionLightAreas:
		lightingAreas.push_back(light)
	AdditionLightAreas.clear()
	
	circle.shape.radius = auraRadius
	
	timeline_type = starting_light
	for light in lightingAreas:
		light.timeline_type = timeline_type
		light.update_sprite()
		light.update_light()
		light.light_priority = lightPriority
	
	lastMousePosition = get_global_mouse_position()


func _process(delta: float) -> void:
	var stickDirection = Input.get_vector("rightStickLeft", "rightStickRight", "rightStickUp", "rightStickDown")
	
	# If the stick is tilted past a tiny deadzone, lock into controller mode
	if stickDirection.length() > 0.1:
		is_using_mouse = false
		
	# Execute the aiming logic based on whatever mode we are currently locked into
	if is_using_mouse:
		# Always look at the mouse, even if it's sitting perfectly still. 
		# If the player walks forward, the flashlight will dynamically track that global coordinate.
		flashlightArea.look_at(get_global_mouse_position())
	else:
		# Only update the rotation if they are actively pushing the stick.
		# If they let go (stick length is 0), it just stays pointing exactly where they left it.
		if stickDirection.length() > 0.1:
			flashlightArea.look_at(global_position + stickDirection)


func _input(event: InputEvent) -> void:
	# If they bump the mouse or click, instantly lock into mouse mode
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		is_using_mouse = true


func _unhandled_input(event): # Listen for a standard Left Mouse Click
	if event.is_action_pressed("lightToggle"):
		$EmitterFlashlight.play()
		swap_timeline()


func swap_timeline() -> void:
	if timeline_type == Global.Timeline.OFF: # do nothin of its off
		return
	# Flip the timeline
	timeline_type = Global.Timeline.FUTURE if timeline_type == Global.Timeline.PRESENT else Global.Timeline.PRESENT
	print(name + " swapping! Current: " + Global.Timeline.keys()[timeline_type])
	
	updateTimeline(timeline_type)


func set_starting_light(isPresent: bool):
	if isPresent:
		updateTimeline(Global.Timeline.PRESENT)
	else:
		updateTimeline(Global.Timeline.FUTURE)


func updateTimeline(type: Global.Timeline):
	timeline_type = type
	for light in lightingAreas:
		#if print("Updating this light to..." + str(Global.Timeline.keys()[timeline_type]))
		light.timeline_type = timeline_type
		light.update_sprite()
		light.update_light()


func getRotation():
	return abs(fmod(flashlightArea.rotation_degrees, 360))/2

func toggleLight(state: bool):
	for light in lightingAreas:
		light.visible = state
	var tempState = timeline_type
	timeline_type = lastUsedLight
	lastUsedLight = tempState
	
	for light in lightingAreas:
		light.timeline_type = timeline_type
		light.update_light()
