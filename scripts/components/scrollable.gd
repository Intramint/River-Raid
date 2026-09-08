extends Node
class_name Scrollable

const SCROLL_SPEED: float = 200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	get_parent().global_position.y += SCROLL_SPEED * delta
