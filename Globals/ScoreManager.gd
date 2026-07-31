extends Node

const LEVEL_SCORES: LevelScoresResource = preload("uid://b8qpoytkrb2hi")

var level_selected: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func get_level_best(level: int) -> int:
	return LEVEL_SCORES.get_level_best(level)

func set_score_for_current_level(score: int) -> void:
	LEVEL_SCORES.try_update_best_score(level_selected, score)
