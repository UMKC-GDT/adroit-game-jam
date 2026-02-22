extends Node2D
class_name FlickeringLight

@onready var beam: QuantumLight = $QuantumLight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	beam.timeline_type = beam.Timeline.FUTURE;
	$Sprite2D.visible= false
	await get_tree().create_timer(5).timeout
	beam.timeline_type = beam.Timeline.PRESENT;
	$Sprite2D.visible= true
	await get_tree().create_timer(5).timeout
	
