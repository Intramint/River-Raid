extends CharacterBody2D
class_name Fighter

const FIRING_OFFSET: float = -53

signal fired(position: Vector2)
signal lost

@export var move_left: String
@export var move_right: String
@export var shoot: String
@export var boost: String
@export var speed: float = 800


func _ready() -> void:
	global_position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - 100)

func _physics_process(delta: float) -> void:
	var direction: int = 0
	if Input.is_action_pressed(move_left):
		direction -= 1
	if Input.is_action_pressed(move_right):
		direction += 1
		
	var motion: Vector2 = Vector2(direction * speed * delta, 0)
	var collision = move_and_collide(motion)
	
	if collision: #exclude fuel later
		if collision.get_collider() is Enemy:
			collision.get_collider().on_hit()
		crash()
	
	if Input.is_action_just_pressed(shoot):
		fired.emit(Vector2(global_position.x, global_position.y + FIRING_OFFSET))
	
	if Input.is_action_pressed(boost):
		GameState.scroll_speed = GameState.BOOSTED_SCROLL_SPEED
	else:
		GameState.scroll_speed = GameState.DEFAULT_SCROLL_SPEED

func reset(new_position: Vector2):
	position = new_position

func crash():
	lost.emit()
	queue_free()
