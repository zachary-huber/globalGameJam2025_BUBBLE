extends Node

var current_song

func _ready() -> void:
	if current_song:
		$mainMusic.play()


func _process(delta: float) -> void:
	pass

func playSong(songName:String):
		# Load the audio stream dynamically from the song_name
	var audio_stream = ResourceLoader.load(songName)  # Assuming the file is in "res://sounds/"
	
	if audio_stream and audio_stream is AudioStream:
		# Set the audio stream to the AudioStreamPlayer3D
		$mainMusic.stream = audio_stream
		$mainMusic.play()  # Play the audio immediately
	else:
		print("Failed to load audio stream.")
	
