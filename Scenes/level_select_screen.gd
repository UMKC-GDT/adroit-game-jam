extends Node2D


var isVisible = false

func _ready() -> void:
	visible = false
	


#if you roess options it turns on level select
func _on_options_pressed() -> void:
	visible = true
	isVisible = true

#if you press x it turn off level select
func _on_exit_pressed() -> void:
	visible = false
	isVisible = false


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
