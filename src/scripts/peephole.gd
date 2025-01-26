extends Interactable



func _ready() -> void:
	interactHintText = "[center]Press [E] to look outside...[/center]"


func _process(delta: float) -> void:
	if GameManager.isPeeping:
		print("Peep time: ", GameManager.timePlayed - GameManager.timeLookStart)
		print("timeLookStart: ", GameManager.timeLookStart)
		print("timePlayed: ", GameManager.timePlayed)
		if GameManager.timePlayed - GameManager.timeLookStart > 10:
			print("You looked TOO LONG!")
			GameManager.doScaryThing()

func interact():
	GameManager.timeLookStart = GameManager.timePlayed
	print("Looking out the peephole.")
	
	GameManager.isPeeping = true
	GameManager.subCamViewport.visible = true
	GameManager.peepholeTexture.visible = true
	
	#GameManager.interactHint.text = ""
	#GameManager.interactNameHint.text = ""
