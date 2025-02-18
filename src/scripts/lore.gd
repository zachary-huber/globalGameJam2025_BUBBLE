extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("lore")
	pass # Replace with function body.

func loreEnd():
	AudioManager.stopSong()
	GameManager.startGame()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func playMusic():
	AudioManager.playSong("res://data/sounds/LoreTunesMaybe.mp3")

func _input(event):
	if event.is_action_pressed("escape"):
		AudioManager.musicPlayer.stop()
		GameManager.startGame()
