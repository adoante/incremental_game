extends StaticBody3D
class_name Upgrader

@export var _worker_state: StateManager.WORKER_STATE
var worker: Node3D

var upgrade_cost: int = 10 :
	get : return upgrade_cost
	
var upgrade_level: int

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		SignalManager.upgrader_state_change.emit(_worker_state)

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		SignalManager.ui_state_change.emit(StateManager.UI_STATE.MAIN)

func _apply_level_multipiler() -> void:
	worker.worker_level = worker.resource.worker_level
	worker.gem_mine_amount = worker.gem_mine_amount * worker.resource.gem_multiplier
	worker.gem_mine_time = worker.gem_mine_time * worker.resource.mine_time_multiplier

func _calculate_upgrade_cost() -> int:
	return int(pow(upgrade_cost, upgrade_level + 1))

func _upgrade_level():
	if not GameManager.gems >= upgrade_cost:
		return
		
	GameManager.sub_gem(upgrade_cost)
	upgrade_level += 1
	
	match worker.worker_level:
		0:
			worker.resource = preload("res://Resources/NPC/level_1_worker.tres")
			worker.worker_level = 1
		1:
			worker.resource = preload("res://Resources/NPC/level_2_worker.tres")
			worker.worker_level = 2
		2:
			worker.resource = preload("res://Resources/NPC/level_3_worker.tres")
			worker.worker_level = 3
		3:
			worker.resource = preload("res://Resources/NPC/level_4_worker.tres")
			worker.worker_level = 4
		4:
			worker.resource = preload("res://Resources/NPC/level_5_worker.tres")
			worker.worker_level = 5
		5:
			worker.resource = preload("res://Resources/NPC/level_6_worker.tres")
			worker.worker_level = 6
		6:
			worker.resource = preload("res://Resources/NPC/level_7_worker.tres")
			worker.worker_level = 7
		7:
			worker.resource = preload("res://Resources/NPC/level_8_worker.tres")
			worker.worker_level = 8
		8:
			worker.resource = preload("res://Resources/NPC/level_9_worker.tres")
			worker.worker_level = 9
		9:
			worker.resource = preload("res://Resources/NPC/level_10_worker.tres")
			worker.worker_level = 10
		_:
			push_error("No worker resource for level: " + str(worker.worker_level + 1))
			return
			
	_apply_level_multipiler()
	upgrade_cost = _calculate_upgrade_cost()
