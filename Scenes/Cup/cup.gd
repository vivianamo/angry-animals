extends StaticBody2D

class_name Cup

func _ready() -> void:
	SignalHub.animal_hit_cup.connect(_on_animal_hit_cup)
	
	
func _on_animal_hit_cup() -> void:
	pass
