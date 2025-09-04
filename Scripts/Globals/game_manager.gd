extends Node

var gems: int = 0 :
	get : return gems

func sub_gem(amount: int) -> void:
	gems -= amount

func add_gem(amount: int) -> void:
	gems += amount
