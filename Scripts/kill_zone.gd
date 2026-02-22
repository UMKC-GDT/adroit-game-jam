extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		body.kill()
		#SHOULD WAIT BRIEFLY AND DISPLAY A MESSAGE
		get_tree().reload_current_scene()
