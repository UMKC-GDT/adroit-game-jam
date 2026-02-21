extends Area2D
#This Scene is meant to be a component of an interactable object.
#If this isn't attached to an object that is meant to be interacted with by the player
#Something went wrong!

signal Interacted()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !(get_child(0)):
		push_error("InteractableComponent of " + get_parent().name + " has no CollisionShape child!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
