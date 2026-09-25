extends Node

func reset():
	GameState.reset()
	get_tree().reload_current_scene()

func _on_fighter_fired(projectile_position: Vector2) -> void:
	var projectile: Projectile = load("res://scenes/projectile.tscn").instantiate()
	projectile.global_position = projectile_position
	add_child(projectile)


func _on_fighter_lost() -> void:
	GameState.scroll_speed = 0
	GameState.lost = true
	$HUD.show_game_over()


func _on_hud_retried() -> void:
	reset()
