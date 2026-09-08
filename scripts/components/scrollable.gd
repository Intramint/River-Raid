extends Node
class_name Scrollable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	get_parent().global_position.y += GameState.SCROLL_SPEED * delta
