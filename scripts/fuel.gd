extends Area2D
class_name Fuel

@export var point_value: int
const FUEL_REPLENSHIED: float = 25

func on_hit():
	GameState.points += point_value
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	GameState.fuel += FUEL_REPLENSHIED
	queue_free()
