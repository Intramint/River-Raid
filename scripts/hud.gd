extends CanvasLayer

signal retried

func _ready() -> void:
	GameState.points_changed.connect(_on_game_state_points_changed)

func _process(delta: float) -> void:
	$FuelBar.value = GameState.fuel
	if $FuelBar.value < 50:
		$FuelBar.modulate = Color.ORANGE
		if $FuelBar.value < 25:
			$FuelBar.modulate = Color.RED
	else:
		$FuelBar.modulate = Color.GREEN
	
func _on_game_state_points_changed():
	$ScoreLabel.text = str(GameState.points)
	
func show_game_over():
	show_message("You lose")
	$RetryButton.show()

func show_message(text: String):
	$MessageLabel.text = text
	$MessageLabel.show()


func _on_retry_button_pressed() -> void:
	retried.emit()
	hide()
