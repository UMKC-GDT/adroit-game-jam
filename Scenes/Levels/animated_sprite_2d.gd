extends AnimatedSprite2D
var stoodUp = false
var catGoned = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if stoodUp == false:
		self.play("standUp")
		stoodUp = true
	pass # Replace with function body.


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if catGoned == false:
		self.play("catGone")
		catGoned = true
	pass # Replace with function body.
