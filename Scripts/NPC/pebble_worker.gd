extends Worker

func _ready() -> void:
	SignalManager.start_pebble_worker.connect(_start_worker)
	SignalManager.upgrade_pebble_worker.connect(_upgrade_level)
	SignalManager.create_pebble_worker.connect(_add_worker)

# Spawn pebbles here
