extends CharacterBody2D
class_name Enemy

enum Type { SHIP }

const SCENES = {
	Type.SHIP: preload("res://scenes/enemy_ship.tscn")
}

func _physics_process(delta: float) -> void:
	move(delta)

func move(delta: float):
	pass

func on_hit():
	queue_free()
