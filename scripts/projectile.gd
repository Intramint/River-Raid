extends Area2D
class_name Projectile

const SPEED: float = 1000


func _physics_process(delta: float) -> void:
	global_position.y -= SPEED * delta
