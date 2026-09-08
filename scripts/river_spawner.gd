extends Node2D

@onready var segment_height: float = abs($TopLeftPoint.position.y - $BottomLeftPoint.position.y)
var distance_since_last_segment: float = 0.0


func _ready() -> void:
	spawn_first_segment()


func _physics_process(delta: float) -> void:
	distance_since_last_segment += GameState.SCROLL_SPEED * delta
	if distance_since_last_segment >= segment_height:
		var remainder: float = distance_since_last_segment - segment_height
		distance_since_last_segment = 0
		var bottom_left_with_offset: Vector2 = $BottomLeftPoint.position
		bottom_left_with_offset.y += remainder
		var bottom_right_with_offset: Vector2 = $BottomRightPoint.position
		bottom_right_with_offset.y += remainder
		spawn_segment($TopLeftPoint.position, $TopRightPoint.position, bottom_right_with_offset, bottom_left_with_offset)

func spawn_segment(top_left: Vector2, top_right: Vector2, bottom_right: Vector2, bottom_left: Vector2):
	var segment: RiverSegment = load("res://scenes/river_segment.tscn").instantiate()
	segment.create(top_left, top_right, bottom_right, bottom_left)
	add_child(segment)

func spawn_first_segment():
	var bottom_left: Vector2 = $BottomLeftPoint.position
	bottom_left.y = get_viewport_rect().size.y
	var bottom_right: Vector2 = $BottomRightPoint.position
	bottom_right.y = get_viewport_rect().size.y
	spawn_segment($TopLeftPoint.position, $TopRightPoint.position, bottom_right, bottom_left)
