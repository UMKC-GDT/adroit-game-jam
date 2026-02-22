extends AnimatedSprite2D
var catBeMeowin = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play("catMeow")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !catBeMeowin:
		self.position.x = self.position.x + 100 * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if catBeMeowin:
		self.play("catRun")
		catBeMeowin = false
		self.scale.x = -2.0
