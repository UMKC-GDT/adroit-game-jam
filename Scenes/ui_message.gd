extends Node2D

@export var image: Texture2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	$Sprite2D.texture = image
	$Sprite2D.scale = Vector2(1,0.0)
	print("Test")
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(1,1), .2) # Replace with function body.
	tween.tween_property($Sprite2D, "modulate:a", 1.0, 1) # Replace with function body
	tween.tween_property($Sprite2D, "modulate:a", 0.0, 1.5) # Replace with function body.
	
