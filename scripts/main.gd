extends Node

func _on_fighter_fired(projectile_position: Vector2) -> void:
	var projectile: Projectile = load("res://scenes/projectile.tscn").instantiate()
	projectile.global_position = projectile_position
	add_child(projectile)


func _on_fighter_lost() -> void:
	GameState.scroll_speed = 0
	GameState.lost = true
