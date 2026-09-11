extends Node

const SPAWN_CHANCE: float = 0.2
const OFFSET_FROM_WALL: float = 100

enum SpawnableType { SHIP, HELICOPTER, FUEL }

const SCENES = {
	SpawnableType.SHIP: preload("res://scenes/enemy_ship.tscn"),
	SpawnableType.HELICOPTER: preload("res://scenes/enemy_helicopter.tscn"),
	SpawnableType.FUEL: preload("res://scenes/fuel.tscn")
}

func _on_river_spawner_segment_generated(x: Vector2, y: float) -> void:
	if randf() <= SPAWN_CHANCE:
		var new_x = randf_range(x[0] + OFFSET_FROM_WALL, x[1] - OFFSET_FROM_WALL)
		spawn(Vector2(new_x, y), choose_random_spawnable()) #change later to random water type

func spawn(position: Vector2, type: SpawnableType):
	var spawned = SCENES[type].instantiate()
	spawned.global_position = position
	add_child(spawned)

func choose_random_spawnable() -> SpawnableType:
	var values = SpawnableType.values()
	return values[randi() % values.size()]
