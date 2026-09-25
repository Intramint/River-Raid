extends Node2D
class_name Fighter

const FIRING_OFFSET: float = -53

signal fired(position: Vector2)
signal lost

@export var move_left: String
@export var move_right: String
@export var shoot: String
@export var boost: String
@export var speed: float = 800
@export var shoot_sound: AudioStream

func _ready() -> void:
	GameState.out_of_fuel.connect(_on_game_state_out_of_fuel)
	global_position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - 100)

func _physics_process(delta: float) -> void:
	var direction: int = 0
	if Input.is_action_pressed(move_left):
		$AnimatedSprite2D.animation = "left"
		direction -= 1
	elif Input.is_action_pressed(move_right):
		$AnimatedSprite2D.animation = "right"
		direction += 1
	else:
		$AnimatedSprite2D.animation = "default"
		
	var motion: Vector2 = Vector2(direction * speed * delta, 0)
	global_position += motion
	
	if Input.is_action_just_pressed(shoot):
		GameState.points -= 1
		AudioManager.play(shoot_sound)
		fired.emit(Vector2(global_position.x, global_position.y + FIRING_OFFSET))
	
	if Input.is_action_pressed(boost):
		GameState.scroll_speed = GameState.BOOSTED_SCROLL_SPEED
	else:
		GameState.scroll_speed = GameState.DEFAULT_SCROLL_SPEED

func reset(new_position: Vector2):
	position = new_position

func crash():
	$Explodable.explode()
	lost.emit()
	queue_free()

func _on_game_state_out_of_fuel():
	crash()

func _on_hurtbox_hurt(source: Node2D) -> void:
	crash()
