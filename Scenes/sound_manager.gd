extends Node2D
class_name SoundManager

enum SoundType
{
	MUSIC,
	SFX,
	AMB
}
enum Emitters{
	TITLE,
	LEVEL,
	PICKUP,
	MUSIC,
	DOOR,
	
}

@export var musicScale: float= 0
@export var soundEffectsScale: float = 0
@export var ambience: float = 0
@export var main: float = 0

@onready var musicEmitter: FmodEventEmitter2D = $musicEmitter
@onready var titleEmitter: FmodEventEmitter2D = $titleEmitter
@onready var levelEmitter: FmodEventEmitter2D = $levelEmitter
@onready var doorEmitter: FmodEventEmitter2D = $doorEmitter
@onready var pickupEmitter: FmodEventEmitter2D = $pickupEmitter


@export var fmodEmitter: FmodEventEmitter2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func UpdateSettings(emitter: FmodEventEmitter2D, soundType: SoundType):
	emitter.volume += main
	emitter.set_parameter("Sfx Volume",soundEffectsScale)
	emitter.set_parameter("Music Volume",musicScale)
	emitter.set_parameter("Ambience Volume",ambience)


func setParameter(emitter: Emitters, param: String, value: int):
	match emitter:
		Emitters.TITLE:
			titleEmitter.set_parameter(param, value)
		Emitters.LEVEL:
			levelEmitter.set_parameter(param, value)
		Emitters.PICKUP:
			pickupEmitter.set_parameter(param, value)
		Emitters.MUSIC:
			musicEmitter.set_parameter(param, value)
		Emitters.DOOR:
			doorEmitter.set_parameter(param, value)

func play(emitter: Emitters):
	match emitter:
		Emitters.TITLE:
			titleEmitter.play()
		Emitters.LEVEL:
			levelEmitter.play()
		Emitters.PICKUP:
			pickupEmitter.play()
		Emitters.MUSIC:
			musicEmitter.play()
		Emitters.DOOR:
			doorEmitter.play()
