extends Node2D
class_name FlickeringLight

@onready var beam: QuantumLight = $QuantumLight
@export var light_priority = 1

var lightOnPresent  = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LampEmitter.play()
	beam.light_priority = light_priority
	beam.update_light()
	
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
var time = 0.0;
func _process(delta: float) -> void:
	time+=delta
	if time>=0.1 and time <=0.21:
		$LampEmitter.set_parameter("LampFlicker", 0)
		if(lightOnPresent):
			beam.timeline_type = beam.Timeline.PRESENT
			beam.update_light()
			lightOnPresent=false
			
		else:
			beam.timeline_type = beam.Timeline.FUTURE
			beam.update_light()
			lightOnPresent=true
		
	
	if time>=1.5:
		time = 0.0
		$LampEmitter.set_parameter("LampFlicker", 1)
		if(lightOnPresent):
			beam.timeline_type = beam.Timeline.PRESENT
			beam.update_light()
			lightOnPresent=false
			
		else:
			beam.timeline_type = beam.Timeline.FUTURE
			beam.update_light()
			lightOnPresent=true


	
	
