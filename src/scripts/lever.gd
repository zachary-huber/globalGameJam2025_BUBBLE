extends Interactable

var leverSensitivity: float = -0.003


func _init() -> void:
	interactHintText = "[center]Sit at chair to engage.[/center]"

func _ready() -> void:
	GameManager.theLever = self # create a reference to this lever so the game manager can manage it
	print(GameManager.theLever)

func _process(delta: float) -> void:
	pass

func interact():
	super()

func alt_interact():
	super()
