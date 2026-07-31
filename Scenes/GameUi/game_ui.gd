extends Control

var _total_cups: int = 1
var _current_cups: int = 0
var _attempts: int = -1

const MAIN = preload("res://Scenes/Main/main.tscn")

@onready var vb_complete: VBoxContainer = $VbComplete
@onready var music: AudioStreamPlayer2D = $Music
@onready var attempts_label: Label = $MarginContainer/VBoxContainer/HBAttempts2/AttemptsLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	_total_cups = get_tree().get_nodes_in_group(Cup.GROUP_NAME).size()
	SignalHub.on_cup_destroyed.connect(on_cup_destroyed)
	SignalHub.on_attempt_made.connect(on_attempt_made)
	on_attempt_made()
	
func on_attempt_made() -> void:
	_attempts += 1
	attempts_label.text = "%03d" % _attempts
	
func on_cup_destroyed() -> void:
	_current_cups += 1
	if _current_cups == _total_cups:
		vb_complete.visible = true
		music.play()
		ScoreManager.set_score_for_current_level(_attempts)
		get_tree().paused = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
			get_tree().change_scene_to_packed(MAIN)
				
