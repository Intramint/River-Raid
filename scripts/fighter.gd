extends CharacterBody2D
class_name Fighter

const FIRING_OFFSET: float = -53

signal fired(position: Vector2)

@export var move_left: String
@export var move_right: String
@export var shoot: String
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
	move_and_collide(motion)
	
	if Input.is_action_just_pressed(shoot):
		fired.emit(Vector2(global_position.x, global_position.y + FIRING_OFFSET))

func reset(new_position: Vector2):
	position = new_position
