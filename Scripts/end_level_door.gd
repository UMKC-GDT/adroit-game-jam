extends LightObject
class_name EndLevelDoor

var gm: game_manager

@export var canOpen: bool
#next scene is the string name of  the scene
@export var nextScene: String
@export var gameManager: game_manager

@onready var future_sprite: AnimatedSprite2D = $FutureSprite
@onready var present_sprite: AnimatedSprite2D = $PresentSprite
@onready var active_sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	if native_timeline == Timeline.FUTURE:
		future_sprite.show()
		active_sprite = future_sprite
		active_sprite.play("Closed")
		present_sprite.hide()
	else:
		future_sprite.hide()
		
		present_sprite.show()
		active_sprite = present_sprite

	if nextScene == null:
		push_error("EndLevelDoor has no nextScene!")
		active_sprite.play("Closed")
	
	super()
	update_state()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movable = false
	is_active = true

var isSwitching = false

func _on_interactable_component_interacted() -> void:
	if (isSwitching):
		pass
	isSwitching = true
	
	if !is_active: return
	
	print("Test animation")
	active_sprite.play("OpenDoor")
	await get_tree().create_timer(.3).timeout
	active_sprite.play("Opened")
	var tree = get_tree()
	if tree != null:
		await tree.create_timer(.2).timeout
		var sceneManager:game_manager = tree.root.get_node("GameManager")
		if (sceneManager != null):
			sceneManager.DoorSound(1)
			sceneManager.LoadNewScene("res://Scenes/Levels/"+nextScene+".tscn")
		else:
				get_tree().change_scene_to_file("res://Scenes/Levels/"+nextScene+".tscn")
		
	#next scene is the string name of  the scene
	#get_tree().change_scene_to_file("res://Scenes/Levels/"+nextScene+".tscn")
	
