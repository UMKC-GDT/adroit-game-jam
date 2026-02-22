extends Area2D
#I should be attached to the player! 
var interactable: Area2D

func handleInteraction():
	if interactable:
		print("interactable!")
		interactable.interacted.emit()

func _on_area_entered(area: Area2D) -> void:
	print("entered")
	interactable = area

func _on_area_exited(area: Area2D) -> void:
	print("exited")
	interactable = null
	
func getInteractable():
	return interactable
