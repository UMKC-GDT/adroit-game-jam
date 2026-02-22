extends Node2D
class_name sound_manager


@export var musicScale: float= 0
@export var soundEffectsScale: float = 0
@export var ambience: float = 0
@export var main: float = 0

@export var fmodEmitter: FmodEventEmitter2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func UpdateSettings(emitter: FmodEventEmitter2D):
	
	emitter.set_parameter("Sfx Volume",soundEffectsScale)
	emitter.set_parameter("Music Volume",musicScale)
	emitter.set_parameter("Ambience Volume",ambience)
	
	pass
