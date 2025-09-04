extends CanvasLayer

@onready var gems: Label = $Gems
@onready var pebbles: Label = $Pebbles
@onready var jailbirds: Label = $Jailbirds

@onready var jailbird_worker: Node3D = $"../JailbirdWorker"
@onready var pebble_worker: Node3D = $"../PebbleWorker"

func _process(_delta: float) -> void:
	gems.text = "Gems: " + str(GameManager.gems)
	
	var pebble_rate = str(pebble_worker.gem_mine_amount) + "/" + str(pebble_worker.gem_mine_time)
	pebbles.text = "Pebbles: " + str(pebble_worker.worker_amount) + "\n" + pebble_rate
	
	var jailbird_rate = str(jailbird_worker.gem_mine_amount) + "/" + str(jailbird_worker.gem_mine_time)
	jailbirds.text = "Jailbirds: " + str(jailbird_worker.worker_amount) + "\n" + jailbird_rate
