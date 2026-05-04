extends Node2D

var gm: game_manager
var settings_menu: Settings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gm = get_tree().get_first_node_in_group("Game Manager")
	settings_menu = get_tree().get_first_node_in_group("Settings")

func _on_start_pressed() -> void:
	gm.soundManager.setParameter(SoundManager.Emitters.TITLE, "TitleOutie", 1)
	var sceneManager:game_manager = find_parent("GameManager")
	if (sceneManager != null):
		var tree = get_tree()
		if tree:
			#await tree.create_timer(3.5).timeout
			gm.soundManager.play(SoundManager.Emitters.LEVEL)
		sceneManager.LoadNewScene("res://Scenes/Levels/Level1.tscn")
		
	else:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")



func _on_options_pressed() -> void:
	settings_menu.show_menu()


func _on_credits_pressed() -> void:
	gm.LoadNewScene("res://Scenes/Levels/credits_scene.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_level_select_pressed() -> void:
	$LevelSelectScreen.visible = true
	#TODO: we need a special sprite for this button. As it stands now, it is the second options button
