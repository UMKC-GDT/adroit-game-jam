extends Node2D

var ballRigid = preload("res://BrandonTesting/BallRigid.tscn")
var currentBall: Node2D
var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if (timer > 5):
		timer = 0;
		print("Dropping Ball")
		
		if (currentBall != null):
			currentBall.queue_free()
			
		currentBall = ballRigid.instantiate()
		add_child(currentBall)
		
		currentBall.global_position = self.global_position
	pass
