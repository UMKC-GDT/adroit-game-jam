extends LightObject
class_name Prism

var gm: game_manager
@export var target: Node2D
@export var target2: Node2D
@export var target3: Node2D
@export var persistent = false

@onready var future_sprite: AnimatedSprite2D = $FutureSprite
@onready var present_sprite: AnimatedSprite2D = $PresentSprite
@onready var active_sprite: AnimatedSprite2D

var is_switch_on: bool = false

#Note: Most of this is Gemini-written, right now

func _ready() -> void:
	
	gm = get_tree().root.get_node("GameManager")
	if gm:
		print_rich("[color=green]", self, " got game manager [/color]")
	else:
		print_rich("[color=red]", self, " could not get game manager[/color]")
	if native_timeline == Global.Timeline.FUTURE:
		future_sprite.show()
		active_sprite = future_sprite
		present_sprite.hide()
	else:
		future_sprite.hide()
		present_sprite.show()
		active_sprite = present_sprite
	
	# ALWAYS call super() so the base LightObject code runs on startup
	super()

func _process(delta: float) -> void:
	
	if is_active:
		if is_switch_on:
			active_sprite.frame = 0
		else:
			active_sprite.frame = 0

# 3. THE QUANTUM LOGIC
func update_state() -> void:
	# Let the parent LightObject do all the heavy lifting for visibility and physics
	super() 
	
	# The erasure: If it no longer exists, it physically resets to the OFF position
	if not is_active:
		if not persistent:
			is_switch_on = false
	elif is_active:
		is_switch_on = is_active
		
		print("I worked!")
		if gm:
			gm.soundManager.play(SoundManager.Emitters.SWITCH)
			gm.soundManager.setParameter(SoundManager.Emitters.LEVEL, "CutMost", 0)
	
	# Every time the light hits it or leaves it, re-evaluate the power
	update_target() 

func update_target() -> void:
	if target:
		target.set_power(is_switch_on)
	if target2:
		target2.set_power(is_switch_on)
	if target3:
		target3.set_power(is_switch_on)
