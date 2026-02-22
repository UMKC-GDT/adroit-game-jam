extends Node

@onready var sprite: AnimatedSprite2D


@export var player: CharacterBody2D
@export var flashlight: Node


func _ready() -> void:
	if (player.hasLight):
		sprite = $"../SpriteLight"
	else:
		sprite = $"../SpriteNolight"
	sprite.visible = true

func faceSprite():
	if(player.hasLight):
		if(flashlight.getRotation() > 135 or flashlight.getRotation() < 45 ):
			setFlipH(false)
		else:
			setFlipH(true)
	else:
		if(player.isMovingRight()):
			setFlipH(false)
		elif(player.isMovingLeft()):
			setFlipH(true)
	if(player.isMoving()):
		sprite.play("move")
	else:
		sprite.play("default")

func setFlipH(flip: bool):
	sprite.flip_h = flip
