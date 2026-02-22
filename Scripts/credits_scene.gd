extends Node2D

func _process(delta: float) -> void:
	$Label.position.y -= 75 * delta
