extends LightObject
class_name UIPopup22

@export var image: Texture2D
@export var requires_input: bool = true
@export var interact_action: String = "interact" # Set this to "ui_accept" or your custom "E" action
@export var bob_height: float = 5.0
@export var bob_speed: float = 4.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var start_y: float = sprite.position.y

var player_inside: bool = false
var tween: Tween

# Called when the node enters the scene tree for the first time, and immediately tells it to check if it's being observed at all. If it's not being observed, calling update_state() here should make it immediately just disappear. After all -- if it's not being observed, it doesn't exist!
func _ready() -> void:
	freeze = !movable
	
	sprite.texture = image
	sprite.scale = Vector2(1,0.0)
	
	update_state()

func _process(delta: float) -> void:
	# Only bother doing the math if the popup is actually visible
	if sprite.modulate.a > 0:
		# Time.get_ticks_msec() keeps the wave looping endlessly
		sprite.position.y = start_y + sin(Time.get_ticks_msec() * 0.001 * bob_speed) * bob_height

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and is_active:
		player_inside = true
		show_popup()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("You left!")
		
		player_inside = false
		hide_popup()

func _unhandled_input(event: InputEvent) -> void:
	if not requires_input: return
	
	# If player is here and hits the button, kill the popup
	if player_inside and event.is_action_pressed(interact_action):
		hide_popup()

func show_popup() -> void:
	if tween: tween.kill() # Stop any current fading
	tween = create_tween().set_parallel(true)
	tween.tween_property(sprite, "scale", Vector2(1,1), 0.2)
	tween.tween_property(sprite, "modulate:a", 1.0, 0.2)

func hide_popup() -> void:
	if tween: tween.kill()
	tween = create_tween().set_parallel(true)
	tween.tween_property(sprite, "scale", Vector2(0,0), 0.2)
	tween.tween_property(sprite, "modulate:a", 0.0, 0.2)

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
			
			if (not light.timeline_type == Global.Timeline.OFF) and light.light_priority > dominant_light.light_priority:
				dominant_light = light
		
		is_active = (dominant_light.timeline_type == native_timeline)
	
	visible = is_active
	
	# Update the tracker for the next time this runs
	was_active = is_active
