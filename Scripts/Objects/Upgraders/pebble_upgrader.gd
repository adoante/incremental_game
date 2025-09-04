extends Upgrader

func _ready() -> void:
	worker = %PebbleWorker
	SignalManager.upgrade_pebble_worker.connect(_upgrade_level)
