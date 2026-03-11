extends Area2D
#I should be attached to the player! 
var interactable: Area2D

#Hello, Trevor! Not gonna lie, you're probably gonna hate me for this.
#For reasons only known to the Lord himself, the interaction system was causing problems with trying to recreate level 1, with the switch and the level exiting door itself, and while I suspect that it was due to something with how it handled overlapping area2D's and quickly entering or exiting the zones, truthfully, I couldn't explain why it wouldn't work.
#I also can't explain why this version works instead. I suspect that it's due to it now force checking for any new interactables when we press the button, but I don't know. I left the old code in, commented out.

#func handleInteraction():
	#if interactable:
		#print("interactable!")
		#interactable.interacted.emit()
	#else:
		#print("There's nothing for me to interact with!")

func handleInteraction():
	var target = getInteractable()
	if target:
		print("interactable!")
		target.interacted.emit()
	else:
		print("There's nothing for me to interact with!")

#func _on_area_entered(area: Area2D) -> void:
	# Only store the area if it's actually an interactable component
	#if area.has_signal("interacted"):
		#print("Valid interactable entered!")
		#interactable = area
	#else:
		#print("Ignored a non-interactable area: ", area.name)
#
#func _on_area_exited(area: Area2D) -> void:
	#if interactable == area:
		#print("Exited the valid interactable!")
		#interactable = null

#func getInteractable():
	#return interactable

func getInteractable() -> Area2D:
	# Get everything we are currently touching
	var overlapping_areas = get_overlapping_areas()
	
	# Loop through and return the first valid interactable we find
	for area in overlapping_areas:
		if area.has_signal("interacted"):
			return area
			
	return null
