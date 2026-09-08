extends Node

@onready var segment_height: float = abs($TopLeftPoint.position.y - $BottomLeftPoint.position.y)
var distance_since_last_segment: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_segment($TopLeftPoint.position, $TopRightPoint.position, $BottomRightPoint.position, $BottomLeftPoint.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
