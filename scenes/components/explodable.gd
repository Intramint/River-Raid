extends Node
class_name Explodable

@export var explode_sound: AudioStream

func explode():
	AudioManager.play_random_pitch(explode_sound)
	#some particle effects
