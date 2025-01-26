extends Interactable


func _init() -> void:
	interactHintText = "[center]Press [E] to pilot the submarine[/center]"

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func interact():
	if GameManager.isAtHelm == true:
		GameManager.isAtHelm = false
		GameManager.playerCamera.current = true
	else:
		GameManager.chairCamera.current = true
		GameManager.isAtHelm = true
