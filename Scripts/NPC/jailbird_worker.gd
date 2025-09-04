extends Worker

func _ready() -> void:
	SignalManager.start_jailbird_worker.connect(_start_worker)
	SignalManager.upgrade_jailbird_worker.connect(_upgrade_level)
	SignalManager.create_jailbird_worker.connect(_add_worker)

# Spawn jailbird here
