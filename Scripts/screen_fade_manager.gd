extends Node2D

@export var nextScene: String
@export var player: CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	self.visible = true
	fadeIn()

func fadeIn():
	animation_player.play("FadeIn")

func fadeOut():
	animation_player.play("FadeOut")

func moveToNextScene():
	get_tree().change_scene(nextScene)
