extends Node

var current_song

func _ready() -> void:
	if current_song:
		$mainMusic.play()


func _process(delta: float) -> void:
	pass
