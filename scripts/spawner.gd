extends Node2D

const SPAWN_CHANCE: float = 0.2
const OFFSET_FROM_WALL: float = 100
const SPAWNABLE_DATA: Array[SpawnableData] = [
	preload("res://assets/resources/ship_data.tres"),
	preload("res://assets/resources/helicopter_data.tres"),
	preload("res://assets/resources/fuel_data.tres"),
	preload("res://assets/resources/jet_data.tres")
]
var spawnable_weights = PackedFloat32Array([])
var draw_pos: Vector2

func _ready() -> void:
	for spawnable in SPAWNABLE_DATA:
		spawnable_weights.append(spawnable.weight)

func _on_river_spawner_segment_generated(x_range: Vector2, y: float) -> void:
	if randf() <= SPAWN_CHANCE:
		var new_x = randf_range(x_range[0] + OFFSET_FROM_WALL, x_range[1] - OFFSET_FROM_WALL)
		var spawnable = choose_random_spawnable()
		if spawnable.water_spawn: 
			spawn(Vector2(new_x, y), spawnable)
		else:
			jet_spawn(spawnable)

func spawn(position: Vector2, data: SpawnableData) -> Node2D:
	var spawned = data.scene.instantiate()
	spawned.global_position = position
	add_child(spawned)
	return spawned
	
func choose_random_spawnable() -> SpawnableData:
	var rng = RandomNumberGenerator.new()
	return SPAWNABLE_DATA[rng.rand_weighted(spawnable_weights)]

func jet_spawn(data: SpawnableData):
	var flipped: bool
	var spawn_start: Vector2
	var spawn_end: Vector2
	if randf() < 0.5:
		flipped = false
		spawn_start = $LeftJetSpawnStart.position
		spawn_end = $LeftJetSpawnEnd.position
	else:
		flipped = true
		spawn_start = $RightJetSpawnStart.position
		spawn_end = $RightJetSpawnEnd.position
	var spawn_point: Vector2 = spawn_start.lerp(spawn_end, randf())
	var jet = spawn(spawn_point, data)
	if (flipped):
		jet.flip()
