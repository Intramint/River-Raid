extends Area2D
class_name Fuel

func on_hit():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Fighter:
		print("o")
