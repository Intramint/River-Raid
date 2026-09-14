extends CanvasLayer

func _process(delta: float) -> void:
	$FuelBar.value = GameState.fuel
	if $FuelBar.value < 50:
		$FuelBar.modulate = Color.ORANGE
		if $FuelBar.value < 25:
			$FuelBar.modulate = Color.RED
	else:
		$FuelBar.modulate = Color.GREEN
