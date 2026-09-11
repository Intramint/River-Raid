extends Node

const DEFAULT_SCROLL_SPEED: int = 600
const BOOSTED_SCROLL_SPEED: int = 1000
const MAX_FUEL: float = 100
const FUEL_CONSUMPTION: float = 3

signal out_of_fuel

var fuel: float = MAX_FUEL:
	set(value):
		if lost:
			return
		else: fuel = clamp(value, 0, MAX_FUEL)

var scroll_speed: int = DEFAULT_SCROLL_SPEED:
	set(value):
		if lost:
			return
		else:
			scroll_speed = value

var lost: bool = false

func _physics_process(delta: float) -> void:
	fuel -= FUEL_CONSUMPTION * delta
	print(fuel)
	if fuel <= 0:
		out_of_fuel.emit()
