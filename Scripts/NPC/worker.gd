extends Node3D
class_name Worker

@export var worker_name    : String  :
	get : return worker_name
	
@export var gem_mine_amount : float  :
	get : return gem_mine_amount
	
@export var gem_mine_time   : float  :
	get : return gem_mine_time

var resource: WorkerResource :
	set (value) : resource = value
	get         : return resource

var worker_amount : int = 0 :
	get : return worker_amount

var worker_level  : int = 0

var worker_rate: float

func _process(_delta: float) -> void:
	var temp_worker_rate = worker_rate
	worker_rate = (gem_mine_amount / gem_mine_time) * worker_amount
	if temp_worker_rate != worker_rate:
		GameManager.add_gem_rate(worker_rate - temp_worker_rate)
	print(worker_name + ": " + str(worker_amount))

# Private Functions
func _add_worker(amount: int) -> void:
	worker_amount += amount
	
