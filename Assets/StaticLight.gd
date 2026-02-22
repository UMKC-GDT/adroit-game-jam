extends Node2D
class_name StaticLight

@onready var beam: QuantumLight = $QuantumLight
@export var light_priority = 1

@export var isPresent  = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	beam.light_priority = light_priority
	
	if(isPresent):
			beam.timeline_type = beam.Timeline.PRESENT
			beam.update_light() 
	else:
		beam.timeline_type = beam.Timeline.FUTURE
		beam.update_light()
		
			
