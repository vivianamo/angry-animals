class_name Animal

extends RigidBody2D

const DRAG_LIM_MAX: Vector2 = Vector2(0,60)
const DRAG_LIM_MIN: Vector2 = Vector2(-60,0)


@onready var label: Label = $Label
@onready var arrow: Sprite2D = $Arrow
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound



var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _is_dragging: bool = false



func _ready() -> void:
	_start = position	
	#sleeping_state_changed.connect(_on_sleeping_state_changed)
	#body_entered.connect(_on_body_entered)
	input_event.connect(_on_input_event)
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		freeze = false
	if event.is_action_pressed("ui_up"):
		apply_central_impulse(Vector2(200, -200))
	
func _process(_delta: float) -> void:
	var debug_str: String = "FR:%s CC:%d SL:%s\n" % [
		freeze,
		get_contact_count(),
		sleeping
	]
	debug_str += "is_draggin:%s drag_start:%.0f, %.0f\n" % [
		_is_dragging,
		_drag_start.x,
		_drag_start.y
	]
	debug_str += "dragged_vector: %.0f, %.0f" % [
		_dragged_vector.x, _dragged_vector.y
	]
	label.text = debug_str

func _physics_process(delta: float) -> void:
	if _is_dragging: handle_dragging()

func handle_dragging() -> void:
	var new_dragged_vector: Vector2 =  get_global_mouse_position() - _drag_start
	new_dragged_vector = new_dragged_vector.clamp(DRAG_LIM_MIN, DRAG_LIM_MAX)
	
	var diff: Vector2 = new_dragged_vector - _dragged_vector
	if diff.length() > 0 and !stretch_sound.playing:
		stretch_sound.play()
	
	_dragged_vector = new_dragged_vector
	position = _start + _dragged_vector

func _on_sleeping_state_changed() -> void:
	print("_on_sleeping_state_changed:", sleeping)# Replace with function body.
	
func _on_body_entered(body: Node) -> void:
	print("_on_body_entered")# Replace with function body.

func start_dragging() -> void:
	arrow.show()
	_is_dragging = true
	_drag_start = get_global_mouse_position()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		#to only get this event once, use disconnect
		# it is possibly to have events automatically disconnect after one firing, by clicking into a signal and changing the advanced settings to One Shot 
		input_event.disconnect(_on_input_event)
		start_dragging()
