extends Node2D

const LEFT_BOUNDARY: float = 150
const RIGHT_BOUNDARY: float = 1920 - 150
const MAX_WIDTH: float = 1500
const MIN_WIDTH: float = 200
const MAX_Y_OFFSET: float = 20
const MIN_Y_OFFSET: float = -20

signal segment_generated(x: Vector2, y: float)

@onready var segment_height: float = abs($TopLeftPoint.position.y - $BottomLeftPoint.position.y)
var distance_since_last_segment: float = 0.0
var segment_count: int = 0

var x_noise: FastNoiseLite
var width_noise: FastNoiseLite
var y_offset_noise: FastNoiseLite

func _ready() -> void:
	spawn_first_segment()
	
	x_noise = FastNoiseLite.new()
	x_noise.seed = randi()
	x_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	
	width_noise = FastNoiseLite.new()
	width_noise.seed = randi()
	width_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	width_noise.frequency = 0.005
	
	y_offset_noise = FastNoiseLite.new()
	y_offset_noise.seed = randi()
	y_offset_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	
	print("x_noise seed: " + str(x_noise.seed) + "\nwidth_noise seed: " + str(width_noise.seed) + "\ny_offset_noise seed " + str(y_offset_noise.seed))

func _physics_process(delta: float) -> void:
	distance_since_last_segment += GameState.scroll_speed * delta
	if distance_since_last_segment >= segment_height:
		var remainder: float = distance_since_last_segment - segment_height
		distance_since_last_segment = 0
		generate_segment(remainder)

func generate_segment(offset: float):
	segment_count += 1
	$BottomLeftPoint.position.x = $TopLeftPoint.position.x
	$BottomRightPoint.position.x = $TopRightPoint.position.x
	var bottom_left_with_offset: Vector2 = $BottomLeftPoint.position
	bottom_left_with_offset.y += offset
	var bottom_right_with_offset: Vector2 = $BottomRightPoint.position
	bottom_right_with_offset.y += offset
	var current_width: float = remap(width_noise.get_noise_1d(segment_count), -1, 1, MIN_WIDTH, MAX_WIDTH)
	var current_y_offset: float = remap(y_offset_noise.get_noise_1d(segment_count), -1, 1, MIN_Y_OFFSET, MAX_Y_OFFSET)
	$TopLeftPoint.position.x = remap(x_noise.get_noise_1d(segment_count), -1, 1, LEFT_BOUNDARY, RIGHT_BOUNDARY - current_width) 
	$TopRightPoint.position.x = remap(x_noise.get_noise_1d(segment_count + current_y_offset), -1, 1, LEFT_BOUNDARY, RIGHT_BOUNDARY - current_width) + current_width
	spawn_segment($TopLeftPoint.position, $TopRightPoint.position, bottom_right_with_offset, bottom_left_with_offset)
	segment_generated.emit(Vector2(($BottomLeftPoint.position.x + $TopLeftPoint.position.x) / 2, ($BottomRightPoint.position.x + $TopRightPoint.position.x) / 2), ($BottomLeftPoint.position.y + $TopLeftPoint.position.y) / 2)

func spawn_segment(top_left: Vector2, top_right: Vector2, bottom_right: Vector2, bottom_left: Vector2):
	var segment: RiverSegment = load("res://scenes/river_segment.tscn").instantiate()
	segment.create(top_left, top_right, bottom_right, bottom_left)
	add_child(segment)

func spawn_first_segment():
	var current_width: float = remap(0, -1, 1, MIN_WIDTH, MAX_WIDTH)
	$TopLeftPoint.position.x = remap(0, -1, 1, LEFT_BOUNDARY, RIGHT_BOUNDARY - current_width) 
	$TopRightPoint.position.x = $TopLeftPoint.position.x + current_width
	$BottomLeftPoint.position.x = $TopLeftPoint.position.x
	$BottomRightPoint.position.x = $TopRightPoint.position.x
	var bottom_left: Vector2 = $BottomLeftPoint.position
	var bottom_right: Vector2 = $BottomRightPoint.position
	bottom_left.y = get_viewport_rect().size.y
	bottom_right.y = get_viewport_rect().size.y
	spawn_segment($TopLeftPoint.position, $TopRightPoint.position, bottom_right, bottom_left)

func get_segment_middle() -> Vector2:
	return Vector2($BottomLeftPoint.position.x, $BottomRightPoint.position.x)
	
