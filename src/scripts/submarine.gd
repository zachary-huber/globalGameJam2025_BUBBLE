extends Node3D


func _ready() -> void:
	GameManager.xCoord = $xCoord
	GameManager.yCoord = $yCoord
	GameManager.o2Label = $o2Label
	GameManager.needle = $Node3D/needle

func _process(delta: float) -> void:
	pass
