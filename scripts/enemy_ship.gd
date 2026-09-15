extends Enemy


const SPEED = 300.0

func _ready() -> void:
	if randf() <= 0.5:
		flip()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func move(delta: float):
	var collision = move_and_collide(Vector2(SPEED * delta * direction, 0))
	if collision:
		flip()
