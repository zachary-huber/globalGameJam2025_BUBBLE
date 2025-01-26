extends Interactable



func _ready() -> void:
	interactHintText = "[center]Press [E] to look outside...[/center]"


func _process(delta: float) -> void:
	pass

func interact():
	GameManager.timeLookStart = GameManager.timePlayed
	print("Looking out the peephole.")
	
	GameManager.isPeeping = true
	GameManager.subCamViewport.visible = true
	GameManager.peepholeTexture.visible = true
	
	AudioManager.airBubbles.play()
	
	#GameManager.interactHint.text = ""
	#GameManager.interactNameHint.text = ""
