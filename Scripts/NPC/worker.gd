extends Node3D
class_name Worker

@onready var _timer: Timer = $Timer

@export var worker_name    : String  :
	get : return worker_name
	
@export var gem_mine_amount : int    :
	get : return gem_mine_amount
	
@export var gem_mine_time   : float  :
	get : return gem_mine_time

var _resource: WorkerResource

var worker_amount : int = 0 :
	get : return worker_amount
var _worker_level  : int = 0

# Private Functions
func _start_worker() -> void:
	if _timer.time_left > 0:
		return
		
	_timer.start()

func _apply_level_multipiler() -> void:
	_worker_level = _resource.worker_level
	gem_mine_amount = gem_mine_amount * _resource.gem_multiplier
	gem_mine_time = gem_mine_time * _resource.mine_time_multiplier
	_timer.wait_time = gem_mine_time

func _add_worker(amount: int) -> void:
	worker_amount += amount

func _upgrade_level():
	match _worker_level:
		0:
			_resource = preload("res://Resources/NPC/level_1_worker.tres")
			_worker_level += 1
		_:
			push_error("No worker resource for level: " + str(_worker_level + 1))
			return
			
	_apply_level_multipiler()

# Signals
func _on_timer_timeout() -> void:
	GameManager.add_gem(gem_mine_amount * worker_amount)
	
