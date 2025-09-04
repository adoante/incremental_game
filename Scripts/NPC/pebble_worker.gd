extends Worker

func _ready() -> void:
	SignalManager.create_pebble_worker.connect(_add_worker)

# Spawn pebbles here
