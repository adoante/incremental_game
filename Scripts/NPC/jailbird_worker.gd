extends Worker

func _ready() -> void:
	SignalManager.create_jailbird_worker.connect(_add_worker)

# Spawn jailbird here
