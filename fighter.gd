extends CharacterBody2D
class_name Fighter

@export var move_left: String
@export var move_right: String
@export var speed: float = 800
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - 100)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction: int = 0
	if Input.is_action_pressed(move_left):
		direction -= 1
	if Input.is_action_pressed(move_right):
		direction += 1
		
	var motion: Vector2 = Vector2(direction * speed * delta, 0)
	move_and_collide(motion)
	
func reset(new_position: Vector2):
	position = new_position
