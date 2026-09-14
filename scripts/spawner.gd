extends Node

const SPAWN_CHANCE: float = 0.2
const OFFSET_FROM_WALL: float = 100
const SPAWNABLE_DATA: Array[SpawnableData] = [
	preload("res://assets/resources/ship_data.tres"),
	preload("res://assets/resources/helicopter_data.tres"),
	preload("res://assets/resources/fuel_data.tres")
]
var spawnable_weights = PackedFloat32Array([])

func _ready() -> void:
	for spawnable in SPAWNABLE_DATA:
		spawnable_weights.append(spawnable.weight)

func _on_river_spawner_segment_generated(x_range: Vector2, y: float) -> void:
	if randf() <= SPAWN_CHANCE:
		var new_x = randf_range(x_range[0] + OFFSET_FROM_WALL, x_range[1] - OFFSET_FROM_WALL)
		spawn(Vector2(new_x, y), choose_random_spawnable()) #change later to random water type

func spawn(position: Vector2, data: SpawnableData):
	var spawned = data.scene.instantiate()
	spawned.global_position = position
	add_child(spawned)
	
func choose_random_spawnable() -> SpawnableData:
	var rng = RandomNumberGenerator.new()
	return SPAWNABLE_DATA[rng.rand_weighted(spawnable_weights)]
