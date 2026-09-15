extends Enemy


const SPEED = 200.0
const MIN_MOVE_TIME: float = 0.5
const MAX_MOVE_TIME: float = 2
const MIN_STOP_TIME: float = 0.2
const MAX_STOP_TIME: float = 3
var moving: bool

func _ready() -> void:
	direction = -1
	if randf() <= 0.5:
		stop_moving()
	else:
		start_moving()
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

func move(delta: float):
	var collision = move_and_collide(Vector2(SPEED * delta * direction * float(moving), 0))
	if collision:
		flip()

func stop_moving():
	moving = false
	await get_tree().create_timer(randf_range(MIN_MOVE_TIME, MAX_MOVE_TIME)).timeout
	start_moving()

func start_moving():
	set_random_direction()
	moving = true
	await get_tree().create_timer(randf_range(MIN_STOP_TIME, MAX_STOP_TIME)).timeout
	stop_moving()

func set_random_direction():
	if randf() <= 0.5:
		flip()
