extends LightObject
class_name SwitchDoor

##This is a door that can only be triggered by a switch. Not to be confused with the spectatular DoorSwitch, the switch that triggers this door.

@onready var future_sprite: Sprite2D = $FutureSprite
@onready var present_sprite: Sprite2D = $PresentSprite

var is_open: bool = false

func _ready() -> void:
	
	if native_timeline == Timeline.FUTURE:
		future_sprite.show()
		present_sprite.hide()
	else:
		future_sprite.hide()
		present_sprite.show()
	
	super()

# DoorSwitch will call this function when triggered
func set_power(state: bool) -> void:
	is_open = state
	update_state() # Re-evaluate the door's physical state

func update_state() -> void:
	# 1. Let the parent class run its timeline math to see if it should exist
	super()
	
	# 2. super() just made it solid if it's in the right timeline. 
	# Now, we override those collisions if the switch says the door is open.
	if is_active and is_open:
		visible = false # Or swap this to an "open" sprite/animation
		
		# Strip away all the collisions that the parent class just turned on
		var physics_layer = 3 if native_timeline == Timeline.PRESENT else 4
		
		call_deferred("set_collision_layer_value", 1, false)
		call_deferred("set_collision_mask_value", 1, false)
		call_deferred("set_collision_layer_value", physics_layer, false)
		call_deferred("set_collision_mask_value", physics_layer, false)
