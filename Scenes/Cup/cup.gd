class_name Cup

extends StaticBody2D

const GROUP_NAME: String = "Cup"

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _enter_tree() -> void:
	add_to_group(GROUP_NAME)


func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)

func die() -> void:
	animation_player.play("vanish")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "vanish":
		SignalHub.emit_on_cup_destroyed()
		queue_free()
