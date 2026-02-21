extends Area2D
#I should be attached to the player! 
var interactable: Area2D

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		if interactable:
			interactable.Interact().emit

func _on_area_entered(area: Area2D) -> void:
	interactable = area

func _on_area_exited(area: Area2D) -> void:
	interactable = null
