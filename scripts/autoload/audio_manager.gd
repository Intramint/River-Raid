extends Node

@onready var players: Array[AudioStreamPlayer] = []
const  POOL_SIZE = 8

func _ready() -> void:
	for i in POOL_SIZE:
		var player = AudioStreamPlayer.new()
		add_child(player)
		players.append(player)

func play(sound: AudioStream):
	var player = get_player()
	player.stream = sound
	player.play()

func play_random_pitch(sound: AudioStream):
	var player = get_player()
	player.stream = sound
	player.pitch_scale += randf_range(-0.2, 0.7)
	player.play()

func get_player() -> AudioStreamPlayer:
	for player in players:
		if not player.playing:
			player.pitch_scale = 1
			return player
	print("Audio player limit exceeded")
	return players[0]
