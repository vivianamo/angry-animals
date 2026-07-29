extends Control


var _total_cups: int = 1
var _current_cups: int = 0

@onready var vb_complete: VBoxContainer = $VbComplete
@onready var music: AudioStreamPlayer2D = $Music



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_total_cups = get_tree().get_nodes_in_group(Cup.GROUP_NAME).size()
	SignalHub.on_cup_destroyed.connect(on_cup_destroyed)
	
func on_cup_destroyed() -> void:
	_current_cups += 1
	if _current_cups == _total_cups:
		vb_complete.visible = true
		music.play()
