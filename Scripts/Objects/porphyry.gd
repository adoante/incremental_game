extends StaticBody3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.get_node("Timer").start()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.get_node("Timer").stop()
