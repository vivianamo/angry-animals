class_name Animal

extends RigidBody2D

const DRAG_LIM_MAX: Vector2 = Vector2(0,60)
const DRAG_LIM_MIN: Vector2 = Vector2(-60,0)
const IMPULSE_MULT: float = 25.0
const IMPULSE_MAX: float = 2000.0

@onready var label: Label = $Label
@onready var arrow: Sprite2D = $Arrow
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound



var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _is_dragging: bool = false
var _arrow_scale_x: float = 0.0


func _ready() -> void:
	_start = position	
	_arrow_scale_x = arrow.scale.x
	#sleeping_state_changed.connect(_on_sleeping_state_changed)
	#body_entered.connect(_on_body_entered)
	input_event.connect(_on_input_event)
	body_entered.connect(_on_body_entered)
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("drag") and _is_dragging:
		call_deferred("start_release")
	
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
	debug_str += "impulse: %.0f, %.0f" % [
		calculate_impulse().x, calculate_impulse().y
	]
	debug_str += "impulse length: %.0f" % [
		calculate_impulse().length()
	]
	label.text = debug_str


func _physics_process(_delta: float) -> void:
	if _is_dragging: handle_dragging()

func calculate_impulse() -> Vector2:
	return _dragged_vector * IMPULSE_MULT * -1

func handle_dragging() -> void:
	var new_dragged_vector: Vector2 =  get_global_mouse_position() - _drag_start
	new_dragged_vector = new_dragged_vector.clamp(DRAG_LIM_MIN, DRAG_LIM_MAX)
	
	var diff: Vector2 = new_dragged_vector - _dragged_vector
	if diff.length() > 0 and !stretch_sound.playing:
		stretch_sound.play()
	
	scale_arrow()
	_dragged_vector = new_dragged_vector
	position = _start + _dragged_vector

func _on_sleeping_state_changed() -> void:
	print("_on_sleeping_state_changed:", sleeping)# Replace with function body.
	
func _on_body_entered(_body: Node) -> void:
	print("Body entered: _body: ", _body)
	SignalHub.emit_animal_hit_cup()

func start_dragging() -> void:
	arrow.show()
	_is_dragging = true
	_drag_start = get_global_mouse_position()

func start_release() -> void:
	launch_sound.play()
	arrow.hide()
	_is_dragging = false
	freeze = false
	apply_central_impulse(calculate_impulse())

func scale_arrow() -> void:
	var imp_len: float = calculate_impulse().length()
	var perc: float = clamp(imp_len / IMPULSE_MAX, 0.0, 1.0)
	# lerp is for linear interpolation, built into godot
	arrow.scale.x = lerpf(_arrow_scale_x, _arrow_scale_x *2, perc)
	arrow.rotation = (_start - position).angle()

func die() -> void:
	SignalHub.emit_on_animal_died()
	queue_free()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		#to only get this event once, use disconnect
		# it is possibly to have events automatically disconnect after one firing, by clicking into a signal and changing the advanced settings to One Shot 
		input_event.disconnect(_on_input_event)
		start_dragging()
