extends Enemy

const SPEED = 600.0

var direction: int = 0

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func move(delta: float):
	move_and_collide(Vector2(SPEED * delta * direction, 0))
