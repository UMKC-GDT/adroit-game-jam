extends Control
# Started by Trevor
#TODO: rest of the fucking system

#Cat Counter
var collectedCats: int = 0
# Star Time: Finish the level before this many seconds have passed to recieve a star.
var elapsedTime: float = 0
const STAR_TIME_LIST: Array[float] = [0, 0, 0, 0, 0, 5.65, 6, 7, 6, 7, 5, 7, 2, 1, 2, 74435345223]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsedTime += delta
	$TimeLabel.text = "%0.2f" % elapsedTime

# Designed to be called by the cats whenever they are discovered.
func cat_collected():
	collectedCats += 1
	$CatLabel.text = ("Cats Found: " + str(collectedCats))
	
# Designed to be called by the game manager whenever a new level is loaded.
func changeLevel(newLevel: int):
	$LevelLabel.text = ("Level " + str(newLevel))
	$TimeLabel.text = 0
	$StarTimeLabel.text = "%0.2f" % STAR_TIME_LIST[newLevel - 1]
