extends Area2D
class_name Fuel

@export var point_value: int
@export var pickup_sound: AudioStream

const FUEL_REPLENSHIED: float = 25

func on_hit():
	GameState.points += point_value
	$Explodable.explode()
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	GameState.fuel += FUEL_REPLENSHIED
	AudioManager.play(pickup_sound)
	queue_free()
