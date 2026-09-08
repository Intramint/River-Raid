extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_segment($TopLeftPoint.position, $TopRightPoint.position, $BottomRightPoint.position, $BottomLeftPoint.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_segment(top_left: Vector2, top_right: Vector2, bottom_right: Vector2, bottom_left: Vector2):
	var segment: RiverSegment = load("res://scenes/river_segment.tscn").instantiate()
	segment.create(top_left, top_right, bottom_right, bottom_left)
	add_child(segment)
