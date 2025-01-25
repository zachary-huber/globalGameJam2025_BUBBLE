extends Interactable


func _ready() -> void:
	interactHintText = "[center]Press [E] to look outside...[/center]"


func _process(delta: float) -> void:
	pass

func interact():
	print("Looking out the peephole.")
	
	GameManager.isPeeping = true
	GameManager.subCamViewport.visible = true
	GameManager.peepholeTexture.visible = true
	
	# make the peep hole viewport and texture visible
	
