class_name LevelSelect extends Control

var gm: game_manager

@onready var page1 = $"GridContainer1-12"
@onready var page2 = $"GridContainer13-24"
@onready var page3 = $"GridContainer25-36" 


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



var page = 1

func _on_next_pressed() -> void:
	if(page == 1):
		page1.visible = false
		page2.visible = true
		$back.visible = true
		$next.visible = true 
		page += 1
	elif(page == 2):
		page2.visible = false
		page3.visible = true
		$back.visible = true
		$next.visible = false 
		page += 1
	

func _on_back_pressed() -> void:
	if(page == 2):
		page1.visible = true
		page2.visible = false
		$back.visible = false
		$next.visible = true 
		page -= 1
	elif(page == 3):
		page2.visible = true
		page3.visible = false
		$back.visible = true
		$next.visible = true 
		page -= 1
		
