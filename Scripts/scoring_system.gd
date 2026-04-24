extends Control
# Started by Trevor
#TODO: rest of the fucking system

#Cat Counter
var collectedCats: int = 0
# Star Time: Finish the level before this many seconds have passed to recieve a star.
var starTime: float
var starTimeList: Array[float] = [0, 0, 0, 0, 0, 5.65]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Designed to be called by the cats whenever they are discovered.
func cat_collected():
	collectedCats += 1
	$CatLabel.text = ("Cats Found: " + str(collectedCats))
	
# Designed to be called by the game manager whenever a new level is loaded.
func changeLevel(newLevel: int):
	$LevelLabel.text = ("Level " + str(newLevel))
	starTime = starTimeList[newLevel - 1]
