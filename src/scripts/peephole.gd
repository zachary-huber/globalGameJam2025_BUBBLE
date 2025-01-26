extends Interactable


var timeLookStart = 0

func _ready() -> void:
	interactHintText = "[center]Press [E] to look outside...[/center]"


func _process(delta: float) -> void:
	if GameManager.isPeeping:
		if GameManager.timePlayed - timeLookStart > 10:
			GameManager.doScaryThing()

func interact():
	timeLookStart = GameManager.timePlayed
	print("Looking out the peephole.")
	
	GameManager.isPeeping = true
	GameManager.subCamViewport.visible = true
	GameManager.peepholeTexture.visible = true
	
	#GameManager.interactHint.text = ""
	#GameManager.interactNameHint.text = ""
