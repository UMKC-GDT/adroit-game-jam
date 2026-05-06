extends Control
# Started by Trevor
#TODO: rest of the fucking system

#Cat Counter
var collectedCats: int = 0
# Star Time: Finish the level before this many seconds have passed to recieve a star.
var elapsedTime: float = 0
const STAR_TIME_LIST: Array[float] = [0, 3, 4, 5, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]

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
func changeLevel(newLevel: String):
	var levelNum: int
	if (newLevel[-7].is_valid_int() && newLevel[-6].is_valid_int()):
		var tempString: String = newLevel[-7]
		tempString += newLevel[-6]
		levelNum = int(tempString)
	elif(newLevel[-6].is_valid_int()):
		var tempString: String = newLevel[-6]
		levelNum = int(tempString)
	else:
		push_error("Level Change Machine Broke. Prof Hare says make invalid states unreachable!")
	print(newLevel)
	$LevelLabel.text = ("Level " + str(levelNum))
	elapsedTime = 0
	$StarTimeLabel.text = "%0.2f" % STAR_TIME_LIST[levelNum]
	if (levelNum != 1): #Maybe we can adjust when the timer and/or star timer show up later. For now its just level 1
		$StarTimeLabel.visible = true
	else:
		$StarTimeLabel.visible = false
