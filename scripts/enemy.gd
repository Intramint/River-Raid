extends CharacterBody2D
class_name Enemy

func _physics_process(delta: float) -> void:
	move(delta)

func move(delta: float):
	pass

func on_hit():
	queue_free()
