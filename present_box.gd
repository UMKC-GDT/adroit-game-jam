extends LightObject

##This script serves an example of how to extend the LightObject for any further quantum-entangled object. Since it extends LightObject, it should still be handling all the observation logic on its own, so we can just add our unique logic in here for when it's active!

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("PresentBox: I'm active and I exist!")
