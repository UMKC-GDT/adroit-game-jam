extends Area2D
class_name QuantumLight

##Class for the concept of quantum light itself, the core mechanic of the game. This light has a specified timeline that it's active on, and a priority for objects to decide who to follow.

enum Timeline { PRESENT, FUTURE }

@export var timeline_type: Timeline = Timeline.PRESENT

@onready var light_sprite: Sprite2D = $LightBeam/LightSprite

var future_color = Color(0.0, 232.594, 235.517, 1.0)
var present_color = Color(1.0, 0.695, 0.434, 1.0)

#Note: DO NOT confuse this with .priority. .priority is something with the Area2D, and as the one writing this comment, I don't know what that's for. But don't try to look for .priority when you mean to look for light_priority. Trust me.
@export var light_priority: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if timeline_type == Timeline.FUTURE:
		#Future: 217,255,255
		light_sprite.modulate = future_color
		
	else:
		#Present: 
		light_sprite.modulate = present_color
	
	pass

func update_light():
	
	# Just poke the objects and tell them to look at your new color
	for body in get_overlapping_bodies():
		if body is LightObject:
			body.update_state()

func _on_body_entered(body: Node2D) -> void:
	if body is LightObject:
		body.add_light(self)

func _on_body_exited(body: Node2D) -> void:
	if body is LightObject:
		body.remove_light(self)
