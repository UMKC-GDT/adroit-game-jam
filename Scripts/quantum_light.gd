extends Area2D
class_name QuantumLight

##Class for the concept of quantum light itself, the core mechanic of the game. This light has a specified timeline that it's active on, and a priority for objects to decide who to follow.

# Moved to Global.gd to allow any script to access it without being a child :)
#enum Timeline { PRESENT, FUTURE, OFF }

@export var timeline_type: Global.Timeline = Global.Timeline.PRESENT

@onready var light_sprite: Sprite2D = $LightBeam/LightSprite

var future_color = Color(0.0, 232.594, 235.517, 0.3)
var present_color = Color(1.0, 0.695, 0.434, 0.3)

#Note: DO NOT confuse this with .priority. .priority is something with the Area2D, and as the one writing this comment, I don't know what that's for. But don't try to look for .priority when you mean to look for light_priority. Trust me.
@export var light_priority: int = 0
@export var light_visible: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#WARNING: QuantumLight relies on signals to call particular functions down below when an object enters or exits its zones. If those signals aren't wired, then the light will detect objects entering it, sure, but it won't ever do what it's supposed to do. This was a lesson discovered in blood and a few hours of confused debugging, so to save future Us, on READY, any QuantumLight source will force-connect its own signals to the proper functions. 
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	if !light_visible:
		light_sprite.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timeline_type == Global.Timeline.OFF: # do nothin of its off
		return
		
	if timeline_type == Global.Timeline.FUTURE:
		#Future: 217,255,255
		if light_sprite:
			light_sprite.modulate = future_color
		
	else:
		#Present:
		if light_sprite:
			light_sprite.modulate = present_color
	
	pass
	
func update_light():
	if timeline_type == Global.Timeline.FUTURE:
		#Future: 217,255,255
		if light_sprite: 
			light_sprite.modulate = future_color
		
	elif timeline_type == Global.Timeline.PRESENT:
		#Present: 
		if light_sprite:
			light_sprite.modulate = present_color
	
	# Just poke the objects and tell them to look at your new color
	for body in get_overlapping_bodies():
		if body is LightObject:
			body.update_state()
			if self.name == "LightArea":
				pass

#WARNING: VERY ESSENTIAL FUNCTIONS! If these aren't wired in any particular QuantumLight, light no work. Check for the holy wifi symbol.
func _on_body_entered(body: Node2D) -> void:
	if body is LightObject:
		body.add_light(self)

func _on_body_exited(body: Node2D) -> void:
	if body is LightObject:
		body.remove_light(self)

func update_sprite():
	if !light_sprite:
		return
	if timeline_type == Global.Timeline.PRESENT:
		light_sprite.modulate = present_color
	elif timeline_type == Global.Timeline.FUTURE:
		light_sprite.modulate = future_color
	
