extends Node

const DEFAULT_SCROLL_SPEED: int = 600
const BOOSTED_SCROLL_SPEED: int = 1000
var scroll_speed: int = DEFAULT_SCROLL_SPEED:
	set(value):
		if lost:
			return
		else:
			scroll_speed = value
var lost: bool = false
