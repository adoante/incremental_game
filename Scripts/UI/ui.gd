extends CanvasLayer


@onready var pebble_worker: Worker = %PebbleWorker
@onready var pebble_upgrader: StaticBody3D = %PebbleUpgrader

@onready var gems: Label = $Gems

@onready var upgrade_panel: Panel = $UpgradePanel
@onready var upgrader_menu: VBoxContainer = $UpgradePanel/UpgraderMenu
@onready var worker_name: Label = $UpgradePanel/UpgraderMenu/WorkerName
@onready var worker_level: Label = $UpgradePanel/UpgraderMenu/WorkerLevel
@onready var worker_rate: Label = $UpgradePanel/UpgraderMenu/WorkerRate
@onready var upgrade_cost: Label = $UpgradePanel/UpgraderMenu/UpgradeCost
@onready var upgrade_button: Button = $UpgradePanel/UpgraderMenu/UpgradeButton


var ui_state     : StateManager.UI_STATE = StateManager.UI_STATE.MAIN
var worker_state : StateManager.WORKER_STATE

func _ready() -> void:
	SignalManager.upgrader_state_change.connect(_set_worker_state)
	SignalManager.ui_state_change.connect(_set_ui_state)

func _process(_delta: float) -> void:
	match ui_state:
		StateManager.UI_STATE.MAIN:
			_main_ui()
		StateManager.UI_STATE.UPGRADE:
			_upgrader_ui(worker_state)

func _set_ui_state(state: StateManager.UI_STATE):
	ui_state = state

func _toggle_upgrade_ui(on_off: bool):
	if on_off:
		upgrade_panel.visible = true
		upgrader_menu.visible = true
		upgrade_button.disabled = false
	else:
		upgrade_panel.visible = false
		upgrader_menu.visible = false
		upgrade_button.disabled = true

func _main_ui() -> void:
	_toggle_upgrade_ui(false)
	gems.text = "Gems: " + str("%0.2f" % GameManager.gems) + "\n" + str("%0.2f" % GameManager.gem_rate) + " gps"
	
func _upgrader_ui(state: StateManager.WORKER_STATE) -> void:
	_toggle_upgrade_ui(true)
	gems.text = "Gems: " + str("%0.2f" % GameManager.gems) + "\n" + str("%0.2f" % GameManager.gem_rate) + " gps"
	match state:
		StateManager.WORKER_STATE.PEBBLE:
			worker_name.text = pebble_worker.worker_name
			worker_level.text = "Level: " + str(pebble_worker.worker_level)
			worker_rate.text = "Rate: " + str((pebble_worker.gem_mine_amount / pebble_worker.gem_mine_time) * pebble_worker.worker_amount) + " gps"
			upgrade_cost.text = "Cost: " + str(pebble_upgrader.upgrade_cost) + " gems"
			
func _set_worker_state(state: StateManager.WORKER_STATE):
	worker_state = state
	ui_state = StateManager.UI_STATE.UPGRADE

func _on_upgrade_button_pressed() -> void:
	match worker_state:
		StateManager.WORKER_STATE.PEBBLE:
			SignalManager.upgrade_pebble_worker.emit()
