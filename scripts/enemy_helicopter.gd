extends Enemy


const SPEED = 200.0
const MIN_MOVE_TIME: float = 0.5
const MAX_MOVE_TIME: float = 2
const MIN_STOP_TIME: float = 0.2
const MAX_STOP_TIME: float = 3
var direction: int

func _ready() -> void:
	if randf() <= 0.5:
		stop_moving()
	else:
		start_moving()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func move(delta: float):
	var collision = move_and_collide(Vector2(SPEED * delta * direction, 0))
	if collision:
		direction *= -1

func stop_moving():
	direction = 0
	await get_tree().create_timer(randf_range(MIN_MOVE_TIME, MAX_MOVE_TIME)).timeout
	start_moving()

func start_moving():
	set_random_direction()
	await get_tree().create_timer(randf_range(MIN_STOP_TIME, MAX_STOP_TIME)).timeout
	stop_moving()

func set_random_direction():
	if randf() <= 0.5:
		direction = 1
	else:
		direction = -1
