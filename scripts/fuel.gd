extends Area2D
class_name Fuel

const FUEL_REPLENSHIED: float = 25

func on_hit():
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	GameState.fuel += FUEL_REPLENSHIED
	queue_free()
