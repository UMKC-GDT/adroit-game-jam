extends RigidBody2D
class_name LightObject

##This is the class for making an object quantum light sensitive, giving it a specified timeline it exists in and allowing it to be sensitive and observed by QuantumLight from either timeline. Ideally, don't use this root class, but extend it for any particular level element, and it will handle light without you needing to touch this. 

#P.S. if you are touching this, something must be dearly wrong. Boohoo.

enum Timeline { PRESENT, FUTURE }
@export var native_timeline: Timeline = Timeline.PRESENT
@export var movable: bool = true
@export var is_tangible: bool = true

#This array stores the lights currently observing this object, to allow us to check who has the most priority and who's say goes.
var overlapping_lights: Array[QuantumLight] = []

#Do you exist? Did you exist?
var is_active: bool
var was_active: bool = true # Tracks the previous state

#Later on, will allow us to store the momentum of objects once they stop being observed.
var stored_linear_vel: Vector2 = Vector2.ZERO
var stored_angular_vel: float = 0.0

@onready var collision_shape = $CollisionShape2D

# Called when the node enters the scene tree for the first time, and immediately tells it to check if it's being observed at all. If it's not being observed, calling update_state() here should make it immediately just disappear. After all -- if it's not being observed, it doesn't exist!
func _ready() -> void:
	freeze = !movable
	
	update_state()

##Called when this object enters a quantum light so it can update its observation state. 
func add_light(light: QuantumLight):
	if not light in overlapping_lights:
		overlapping_lights.append(light)
	update_state()

##Called when this object leaves a quantum light, so it can update its observation state.
func remove_light(light: QuantumLight):
	overlapping_lights.erase(light)
	update_state()

##The big honcho. Called when this object enters the scene and when we observe or unobserve it. Based on the priority of the overlapping lights when its called, decides whether this object is active or not and handles programmatic physics and appearance.
func update_state():
	
	#If no one's looking at us, we don't exist. Otherwise, check for the most dominant light that's looking at us, and follow what it says.
	if overlapping_lights.is_empty():
		is_active = false
	else:
		
		var dominant_light = overlapping_lights[0]
		for light in overlapping_lights:
			
			if light.light_priority > dominant_light.light_priority:
				dominant_light = light
		
		# We exist ONLY if the dominant light matches our timeline
		is_active = (dominant_light.timeline_type == native_timeline)
	
	# In case we WERE active and now we're not, save our momentum for when we can exist again.
	if was_active and not is_active:
		stored_linear_vel = linear_velocity
		stored_angular_vel = angular_velocity
	
	visible = is_active
	
	#Some of the more fancy physics and layers stuff happens below. For a note, we call "deferred" to add it to Godot's execution queue so it finishes whatever current physics calculations its doing BEFORE it starts handling our BS. 
	
	#Turn off gravity and any physics. We force sleeping to be false when we're active so we give this object's physics a kick in the pants to work.
	if movable:
		set_deferred("freeze", !is_active)
		if is_active:
			set_deferred("sleeping", false)

	if is_tangible:
		# Here, we specify physics to be on two different layers so that a Present object and a Future object can exist in the same coordinates without seeing each other. 
		var physics_layer = 3 if native_timeline == Timeline.PRESENT else 4
		
		#Set our world layer and mask, so it only collides if it's meant to exist at the moment.
		call_deferred("set_collision_layer_value", 1, is_active) # World Layer
		call_deferred("set_collision_mask_value", 1, is_active)  # World Mask
		
		#Set that specified physics layer to be active or not if we're meant to exist.
		call_deferred("set_collision_layer_value", physics_layer, is_active)
		call_deferred("set_collision_mask_value", physics_layer, is_active)

	#Waking us back up? Restore our physics. 
	if not was_active and is_active:
		call_deferred("_restore_momentum")
	
	# Update the tracker for the next time this runs
	was_active = is_active

##TELL EM TO BRING OUT THE LOBSTER! (restores physics)
func _restore_momentum():
	linear_velocity = stored_linear_vel
	angular_velocity = stored_angular_vel
