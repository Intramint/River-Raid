extends Node

@onready var players: Array[AudioStreamPlayer] = []
const  POOL_SIZE = 8

func _ready() -> void:
	for i in POOL_SIZE:
		var player = AudioStreamPlayer.new()
		add_child(player)
		players.append(player)

func play(sound: AudioStream):
	for player in players:
		if not player.playing:
			player.stream = sound
			player.play()
			return
