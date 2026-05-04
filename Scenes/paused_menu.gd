class_name PauseMenu extends Control

var settings: Settings
var gm: game_manager
var levels: level_select


var settings_shown: bool = false

func _ready() -> void:
	gm = get_tree().get_first_node_in_group("Game Manager")
	settings = get_tree().get_first_node_in_group("Settings")
	levels = get_tree().get_first_node_in_group("Level Select")
	settings.pause_menu = self
	settings.gm = gm

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") and !gm.isMainMenu:
		if settings_shown:
			settings.hide_menu()
			visible = true
		elif levels.isVisible:
			levels.hide_menu()
			visible = true
		else:
			visible = !visible
			get_tree().paused = !get_tree().paused


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	Input.action_press("escape")


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/GameManager.tscn")


func _on_options_pressed() -> void:
	settings.show_menu()
	visible = false
	settings_shown = true
