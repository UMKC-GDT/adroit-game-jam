class_name LevelSelect extends Control

var gm: game_manager

var isVisible = false

func _ready() -> void:
	visible = false

func show_menu():
	visible = true
	isVisible = true

func hide_menu():
	visible = false
	isVisible = false
	get_tree().call_group("Main Menu", "enable_buttons")


#if you press options it turns on level select
func _on_options_pressed() -> void:
	show_menu()

#if you press x it turn off level select
func _on_exit_pressed() -> void:
	hide_menu()
	Input.action_press("escape")


func _on_next_pressed() -> void:
	$"GridContainer1-12".visible = false
	$"GridContainer13-24".visible = true
	$back.visible = true
	$next.visible = false 


func _on_back_pressed() -> void:
	$"GridContainer1-12".visible = true
	$"GridContainer13-24".visible = false
	$back.visible = false
	$next.visible = true 
