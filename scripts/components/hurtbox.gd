extends Area2D
class_name Hurtbox

signal hurt(source: Node2D)

func _on_area_entered(area: Area2D) -> void:
	hurt.emit(area)


func _on_body_entered(body: Node2D) -> void:
	hurt.emit(body)
