extends BasicPlatform
class_name RandomPlatform

@export var exist_chance = 0.5

##This will be a platform that will randomly decide whether or not it's active, every time it's viewed.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if native_timeline == Timeline.FUTURE:
		future_sprite.show()
		present_sprite.hide()
	else:
		future_sprite.hide()
		present_sprite.show()
	
	super()

func update_state():
	
	#If no one's looking at us, we don't exist. Otherwise, check for the most dominant light that's looking at us, and follow what it says.
	if overlapping_lights.is_empty():
		is_active = false
	else:
		
		var dominant_light = overlapping_lights[0]
		for light in overlapping_lights:
			
			if light.light_priority > dominant_light.light_priority:
				dominant_light = light
		
		# We exist ONLY if...we land a 50/50 shot.
		if randf() <= exist_chance:
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
		
		#Set our world layer and mask, so it only collides if it's meant to exist at the moment.
		if walljump:
			print("We're walljumpable!")
			call_deferred("set_collision_layer_value", 12, is_active) # World Layer
			call_deferred("set_collision_mask_value", 12, is_active)  # World Mask

	#Waking us back up? Restore our physics. 
	if not was_active and is_active:
		call_deferred("_restore_momentum")
	
	# Update the tracker for the next time this runs
	was_active = is_active


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
