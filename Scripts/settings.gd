class_name Settings extends Control


@onready var resolution_options: MenuButton = $PanelContainer/VBoxContainer/Resolution/resolutions
@onready var window_options: MenuButton = $"PanelContainer/VBoxContainer/Window Type/types"

var gm: game_manager
var pause_menu: PauseMenu

func _ready() -> void:
	resolution_options.get_popup().id_pressed.connect(_on_resolution_selected)
	window_options.get_popup().id_pressed.connect(_on_window_mode_selected)
	var bus = FmodServer.get_bus("bus:/")
	$"PanelContainer/VBoxContainer/Volume/volume slider".value = bus.get_volume()

func show_menu():
	visible = true
	get_tree().paused = true

func hide_menu():
	visible = false
	if gm.isMainMenu:
		get_tree().paused = false
		get_tree().call_group("Main Menu", "enable_buttons")
	else:
		Input.action_press("escape")
		pause_menu.settings_shown = false

func _on_volume_slider_value_changed(value: float) -> void:
	var bus = FmodServer.get_bus("bus:/")
	bus.set_volume(value)

func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	gm.soundManager.play(SoundManager.Emitters.SETTINGS)


func _on_resolution_selected(id):
	get_viewport().get_window().unresizable = false
	var center := DisplayServer.screen_get_size()/2
	var resolution: Vector2i
	match id:
		0: resolution = Vector2i(854, 480)
		1: resolution = Vector2i(1024, 768)
		2: resolution = Vector2i(1280, 720)
		3: resolution = Vector2i(1400, 1050)
		4: resolution = Vector2i(1600, 900)
		5: resolution = Vector2i(1920, 1080)
		6: resolution = Vector2i(2560, 1440)
		7: resolution = Vector2i(3840, 2160)
	DisplayServer.window_set_size(resolution)
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_position(center - resolution/2)
	resolution_options.text = str(resolution).trim_prefix("(").trim_suffix(")").replace(", ", "x")
	get_viewport().get_window().unresizable = false

func _on_window_mode_selected(id):
	var mode
	match id:
		0: 
			mode = DisplayServer.WINDOW_MODE_FULLSCREEN 
			window_options.text = "Fullscreen"
		1: 
			mode = DisplayServer.WINDOW_MODE_WINDOWED
			window_options.text = "Windowed"
		2: 
			mode = DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
			window_options.text = "Exclusive"
	DisplayServer.window_set_mode(mode)
	


func _on_button_pressed() -> void:
	hide_menu()
