extends Node

@onready var gem_timer: Timer = $GemTimer
var gem_rate: float = 0.0

var gems: float = 0 :
	get : return gems

func sub_gem(amount: float) -> void:
	gems -= amount

func add_gem(amount: float) -> void:
	gems += amount

func add_gem_rate(amount: float) -> void:
	gem_rate += amount

func _on_gem_timer_timeout() -> void:
	add_gem(gem_rate)
