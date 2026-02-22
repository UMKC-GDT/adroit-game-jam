extends Node2D
class_name FlickeringLight

@onready var beam: QuantumLight = $QuantumLight

var lightOnPresent  = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
var time = 0.0;
func _process(delta: float) -> void:
	time+=delta
	if time>=0.1 and time <=0.2:
		
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
		if(lightOnPresent):
			beam.timeline_type = beam.Timeline.PRESENT
			beam.update_light()
			lightOnPresent=false
			
		else:
			beam.timeline_type = beam.Timeline.FUTURE
			beam.update_light()
			lightOnPresent=true


	
	
