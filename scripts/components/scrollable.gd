extends Node
class_name Scrollable


func _physics_process(delta: float) -> void:
	get_parent().global_position.y += GameState.scroll_speed * delta
