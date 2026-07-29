extends TextureButton



@export var level_number: int = 1

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var level_label: Label = $MarginContainer/VB/LevelLabel



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = str(level_number)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

func _on_mouse_entered() -> void:
	animation_player.play("mouse_entered")


func _on_mouse_exited() -> void:
	animation_player.play("mouse_exited")


func _on_pressed() -> void:
	# We're making the assumption that this does exist, if not the program will crash :>
	get_tree().change_scene_to_file(
		"res://Scenes/LevelBase/level_%d.tscn" % level_number
	)
	
