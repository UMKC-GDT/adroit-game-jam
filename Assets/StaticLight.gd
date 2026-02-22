extends Node2D

@onready var beam: QuantumLight = $QuantumLight

@export var isPresent  = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(isPresent):
			beam.timeline_type = beam.Timeline.PRESENT
			beam.update_light() 
	else:
		beam.timeline_type = beam.Timeline.FUTURE
		beam.update_light()
		
			
