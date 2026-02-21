extends LightObject
class_name PresentBox

##This script serves an example of how to extend the LightObject for any further quantum-entangled object. Since it extends LightObject, it should still be handling all the observation logic on its own, so we can just add our unique logic in here for when it's active!

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	#if is_active:
	#	print("PresentBox: I'm active and I exist!")
	#	print(observer_count)
