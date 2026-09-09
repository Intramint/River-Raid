extends Node

const SPAWN_CHANCE: float = 0.2
const OFFSET_FROM_WALL: float = 100

func _on_river_spawner_segment_generated(x: Vector2, y: float) -> void:
	if randf() <= SPAWN_CHANCE:
		var new_x = randf_range(x[0] + OFFSET_FROM_WALL, x[1] - OFFSET_FROM_WALL)
		spawn(Vector2(new_x, y), choose_random_enemy()) #change later to random water type

func spawn(position: Vector2, type: Enemy.Type):
	var enemy: Enemy = Enemy.SCENES[type].instantiate()
	enemy.global_position = position
	add_child(enemy)

func choose_random_enemy() -> Enemy.Type:
	var values = Enemy.Type.values()
	return values[randi() % values.size()]
