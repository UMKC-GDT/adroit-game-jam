extends Area2D
class_name QuantumLight

##Class for the concept of quantum light itself, the core mechanic of the game. This light has a specified timeline that it's active on, and a priority for objects to decide who to follow.

enum Timeline { PRESENT, FUTURE }

@export var timeline_type: Timeline = Timeline.PRESENT

#Note: DO NOT confuse this with .priority. .priority is something with the Area2D, and as the one writing this comment, I don't know what that's for. But don't try to look for .priority when you mean to look for light_priority. Trust me.
@export var light_priority: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is LightObject:
		body.add_light(self)

func _on_body_exited(body: Node2D) -> void:
	if body is LightObject:
		body.remove_light(self)
