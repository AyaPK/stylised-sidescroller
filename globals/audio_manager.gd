extends Node

var music_audio_player_count: int = 2
var current_music_player: int = 0
var music_players: Array[AudioStreamPlayer] = []
var sfx_player: AudioStreamPlayer
var music_bus: String = "Master"
const LOOP_1_HELLO_WORLD = preload("res://assets/music/LOOP_1_Hello_World.wav")
var special_queue: AudioStream = null
var low_pass_filter = AudioEffectLowPassFilter.new()
var audio_bus
var master_bus
var music_fade_duration: float = 0.5

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for i in music_audio_player_count:
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(player)
		player.bus = music_bus
		music_players.append(player)
		player.max_polyphony = 2
		
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	sfx_player.bus = "SFX"
	sfx_player.max_polyphony = 10
	audio_bus = AudioServer.get_bus_index("SFX")
	master_bus = AudioServer.get_bus_index("Master")
	AudioServer.add_bus_effect(master_bus, low_pass_filter)
	AudioServer.get_bus_effect(master_bus, 0).cutoff_hz = 12000
	play_music(LOOP_1_HELLO_WORLD)

func play_music(_audio: AudioStream) -> void:
	if special_queue:
		music_players[0].stream = special_queue
		music_players[0].play(0)
		special_queue = null
		return
	if _audio == music_players[current_music_player].stream:
		return
	music_players[0].stream = _audio
	music_players[0].play(0)

func play_sfx(_audio: AudioStream) -> void:
	if !_audio:
		return
	sfx_player.stream = _audio
	sfx_player.play(0)
	
func decrease_low_pass() -> void:
	if AudioServer.get_bus_effect(master_bus, 0).cutoff_hz >= 200:
		AudioServer.get_bus_effect(master_bus, 0).cutoff_hz -= 30
		AudioServer.set_bus_volume_db(master_bus, AudioServer.get_bus_volume_db(master_bus)-0.03)

func increase_low_pass() -> void:
	if AudioServer.get_bus_effect(master_bus, 0).cutoff_hz <= 12000:
		AudioServer.get_bus_effect(master_bus, 0).cutoff_hz += 30
		AudioServer.set_bus_volume_db(master_bus, AudioServer.get_bus_volume_db(master_bus)+0.03)
