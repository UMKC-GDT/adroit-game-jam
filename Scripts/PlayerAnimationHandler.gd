extends Node

@onready var sprite: AnimatedSprite2D


@export var player: CharacterBody2D


func _ready() -> void:
	print(player)
	if (player.hasLight):
		sprite = $"../SpriteLight"
	else:
		sprite = $"../SpriteNolight"
	sprite.visible = true


func faceSprite():
	if(player.isMovingRight()):
		setFlipH(false)
		sprite.play("move")
	elif(player.isMovingLeft()):
		setFlipH(true)
		sprite.play("move")
	else:
		sprite.play("default")

func setFlipH(flip: bool):
	sprite.flip_h = flip
