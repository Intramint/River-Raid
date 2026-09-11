extends Area2D
class_name Fuel

func on_hit():
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	#add fuel
	queue_free()
