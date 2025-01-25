extends Interactable


func _init() -> void:
	interactHintText = "[center]Press [E] to pilot the submarine[/center]"

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func interact():
	GameManager.chairCamera.current = true
	GameManager.isAtHelm = true
