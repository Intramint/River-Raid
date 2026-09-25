extends Node
class_name Explodable

@export var explode_sound: AudioStream

func explode():
	AudioManager.play(explode_sound)
	#some particle effects
