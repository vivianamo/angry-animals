extends Node

const ANIMAL = preload("uid://4nroecuchobm")

@onready var start: Marker2D = $Start
@onready var animal_holder: Node = $AnimalHolder


func _ready() -> void:
	SignalHub.on_animal_died.connect(SpawnAnimal)
	SpawnAnimal()


func SpawnAnimal() -> void:
	var new_animal: Animal = ANIMAL.instantiate()
	new_animal.position = start.position
	animal_holder.call_deferred("add_child", new_animal)
