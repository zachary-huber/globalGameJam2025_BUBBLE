extends Node

var current_song

func _ready() -> void:
	if current_song: playSong(current_song)


func _process(delta: float) -> void:
	pass

func playSong(song_file_path):
	var new_audio_stream = load(song_file_path)
	
	if new_audio_stream is AudioStream:
		$musicPlayer.stream = new_audio_stream
		$musicPlayer.play()
