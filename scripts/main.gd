extends Node


func _on_fighter_fired(projectile_position: Vector2) -> void:
	var projectile: Projectile = load("res://scenes/projectile.tscn").instantiate()
	projectile.global_position = projectile_position
	add_child(projectile)
