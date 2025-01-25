extends Control



func _ready() -> void:
	GameManager.interactHint = $interactHint
	GameManager.interactNameHint = $interactNameHint


func _process(delta: float) -> void:
	pass
