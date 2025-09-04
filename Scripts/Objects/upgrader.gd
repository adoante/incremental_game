extends StaticBody3D

@export var _worker: StateManager.WORKER_STATE

var upgrade_cost: int = 10
var upgrade_level: int

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and GameManager.gems >= upgrade_cost:
		match _worker:
			StateManager.WORKER_STATE.PEBBLE:
				SignalManager.upgrade_pebble_worker.emit()
		GameManager.sub_gem(upgrade_cost)
		
		upgrade_level += 1
		upgrade_cost = int(pow(upgrade_cost, upgrade_level))
		
