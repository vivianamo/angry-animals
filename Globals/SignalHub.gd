extends Node


signal on_animal_died
signal animal_hit_cup

func emit_on_animal_died() -> void:
	on_animal_died.emit()

func emit_animal_hit_cup() -> void:
	animal_hit_cup.emit()
