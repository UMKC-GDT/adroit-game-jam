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
		if(player.getDirectionForWallJump() == -1):
			setFlipH(true)
		elif(player.getDirectionForWallJump() == 1):
			setFlipH(false)
		elif(flashlight.getRotation() > 135 or flashlight.getRotation() < 45 ):
			setFlipH(false)
		else:
			setFlipH(true)
	else:
		if(player.isMovingRight()):
			setFlipH(false)
		elif(player.isMovingLeft()):
			setFlipH(true)
		

func animateSprite():
	if(player.isMoving() and player.is_on_floor()):
		sprite.play("move")
	elif(!player.is_on_floor() and player.getDirectionForWallJump() != 0):
		sprite.play("wallSlide")
	elif(!player.is_on_floor()):
		sprite.play("inAir")
	else:
		sprite.play("default")

func setFlipH(flip: bool):
	sprite.flip_h = flip

func playJump():
	sprite.play("jump")

func playWallJump():
	sprite.play("wallJump")

func giveFlashlight():
	sprite.visible = false
	sprite = $"../SpriteLight"
	sprite.visible = true

func takeFlashlight():
	sprite.visible = false
	sprite = $"../SpriteNolight"
	sprite.visible = true
