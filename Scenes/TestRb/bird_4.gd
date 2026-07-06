extends RigidBody2D

@onready var label: Label = $Label


func _ready() -> void:
	#sleeping_state_changed.connect(_on_sleeping_state_changed)
	#body_entered.connect(_on_body_entered)
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		freeze = false
	if event.is_action_pressed("ui_up"):
		apply_central_impulse(Vector2(200, -200))
	
func _process(_delta: float) -> void:
	label.text = "Freeze:%s\nContactCount:%d\nSleeping:%s" % [
		freeze,
		get_contact_count(),
		sleeping
	]

func _on_sleeping_state_changed() -> void:
	print("_on_sleeping_state_changed:", sleeping)# Replace with function body.
	
func _on_body_entered(body: Node) -> void:
	print("_on_body_entered")# Replace with function body.
	
