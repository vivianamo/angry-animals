extends Area2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _input" % name)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _unhandled_input" % name)


func _unhandled_key_input(event: InputEvent) -> void:
	var NameAndEvent: String = name + event.as_text()
	print("%s _unhandled_key_input" % NameAndEvent)

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		print("%s _input_event" % name)
