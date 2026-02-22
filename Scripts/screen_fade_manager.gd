extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	self.visible = true
	
func fadeIn():
	animation_player.play("FadeIn")

func fadeOut():
	animation_player.play("FadeOut")

func moveToNextScene():
	pass
