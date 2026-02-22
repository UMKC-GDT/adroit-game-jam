extends AnimatedSprite2D
var catBeMeowin = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play("catMeow")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if catBeMeowin == true:
		self.play("catRun")
		catBeMeowin = false
		self.scale.x = -2.0
		while self.position.x <= 500:
			self.position.x = self.position.x + 1
			var temp = get_tree()
			if temp:
				await get_tree().create_timer(0.01).timeout
	pass # Replace with function body.
