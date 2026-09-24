extends CanvasLayer

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
