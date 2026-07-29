extends ColorRect

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _input" % name)
		
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _unhandled_input" % name)

func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag"):
		print("%s _gui_input" % name)
	
