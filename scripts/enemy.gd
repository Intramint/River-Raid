extends CharacterBody2D
class_name Enemy

@export var point_value: int
var direction: int = 1

func _physics_process(delta: float) -> void:
	move(delta)

func move(delta: float):
	pass

func flip():
	direction *= -1
	scale.x *= -1


func _on_hurtbox_hurt(source: Node2D) -> void:
	GameState.points += point_value
	$Explodable.explode()
	queue_free()
