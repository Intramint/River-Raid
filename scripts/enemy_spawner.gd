extends Node

const SPAWN_CHANCE: float = 0.2

func _on_river_spawner_segment_generated(x: Vector2, y: float) -> void:
	if randf() <= SPAWN_CHANCE:
		var new_x = randf_range(x[0], x[1])
		spawn(Vector2(new_x, y))

func spawn(position: Vector2): #add Enemy.Type
	var enemy: Enemy = load("res://scenes/enemy.tscn").instantiate()
	enemy.global_position = position
	add_child(enemy)
