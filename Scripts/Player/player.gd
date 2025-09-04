extends CharacterBody3D

@onready var timer: Timer = $Timer

@export var _pebble_mine_amount : int = 1
@export var _pebble_mine_time   : int = 1

@export_group("Input Actions")
## Name of Input Action to move Left.
@export var input_left : String = "ui_left"
## Name of Input Action to move Right.
@export var input_right : String = "ui_right"
## Name of Input Action to move Forward.
@export var input_forward : String = "ui_up"
## Name of Input Action to move Backward.
@export var input_back : String = "ui_down"

var move_speed : float = 5.0

func _ready() -> void:
	timer.wait_time = _pebble_mine_time

func _physics_process(delta: float) -> void:
	_movement(delta)

# Private Functions
func _movement(delta: float) -> void:
	# Apply gravity to velocity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Apply desired movement to velocity
	var input_dir := Input.get_vector(input_left, input_right, input_forward, input_back)
	var move_dir := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if move_dir:
		velocity.x = move_dir.x * move_speed
		velocity.z = move_dir.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)
	
	# Use velocity to actually move
	move_and_slide()
	
# Signals
func _on_timer_timeout() -> void:
	SignalManager.create_pebble_worker.emit(_pebble_mine_amount)
