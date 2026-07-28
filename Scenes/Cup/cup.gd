class_name Cup

extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)

func die() -> void:
	animation_player.play("vanish")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "vanish":
		queue_free()
