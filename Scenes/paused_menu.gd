class_name PauseMenu extends Control

var gm: game_manager

func _ready() -> void:
	gm = get_tree().get_first_node_in_group("Game Manager")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") and !gm.isMainMenu:
		visible = !visible
		get_tree().paused = !get_tree().paused



func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	Input.action_press("escape")


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/GameManager.tscn")
