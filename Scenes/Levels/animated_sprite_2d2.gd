extends AnimatedSprite2D
var hasVented = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if hasVented == false:
		self.play("catSus")
		hasVented = true
	pass # Replace with function body.
