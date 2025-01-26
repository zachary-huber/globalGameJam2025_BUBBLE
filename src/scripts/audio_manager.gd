extends Node

var current_song

@onready var musicPlayer = $musicPlayer 
@onready var soundPlayer = $soundPlayer 
@onready var ambienceHum = $ambienceHum 
@onready var ambienceWater = $ambienceWater 
@onready var ambiencePing = $ambiencePing 
@onready var oxygenAlarm = $oxygenAlarm 
@onready var AudioStreamPlayer2 = $AudioStreamPlayer2 
@onready var AudioStreamPlayer3 = $AudioStreamPlayer3


func _ready() -> void:
	if current_song: playSong(current_song)


func _process(delta: float) -> void:
	pass

func playSong(song_file_path):
	var new_audio_stream = load(song_file_path)
	
	if new_audio_stream is AudioStream:
		$musicPlayer.stream = new_audio_stream
		$musicPlayer.play()

func playSound(file_path):
	var new_audio_stream = load(file_path)
	
	if new_audio_stream is AudioStream:
		$soundPlayer.stream = new_audio_stream
		$soundPlayer.play()

func stopSong():
	$musicPlayer.stop()
