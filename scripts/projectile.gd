extends Area2D
class_name Projectile

const SPEED: float = 1000


func _physics_process(delta: float) -> void:
	global_position.y -= SPEED * delta

func _on_area_entered(area: Area2D) -> void:
	if area is Fuel:
		area.on_hit()
	if area is Hurtbox:
		pass
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	pass
	#queue_free()
