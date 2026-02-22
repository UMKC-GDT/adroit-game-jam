extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Level1 Future".process_mode = Node.PROCESS_MODE_DISABLED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_light_switch_turned_off() -> void:
	$"Level1 Past".process_mode = Node.PROCESS_MODE_DISABLED
	$"Level1 Past".visible = false
	$"Level1 Future".process_mode = Node.PROCESS_MODE_INHERIT
	$"Level1 Future".visible = true


func _on_light_switch_turned_on() -> void:
	$"Level1 Future".process_mode = Node.PROCESS_MODE_DISABLED
	$"Level1 Future".visible = false
	$"Level1 Past".process_mode = Node.PROCESS_MODE_INHERIT
	$"Level1 Past".visible = true
