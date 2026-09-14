extends CharacterBody2D
class_name Enemy

@export var point_value: int

func _physics_process(delta: float) -> void:
	move(delta)

func move(delta: float):
	pass

func on_hit():
	GameState.points += point_value
	queue_free()
