extends Node3D


func _ready() -> void:
	GameManager.xCoord = $xCoord
	GameManager.yCoord = $yCoord


func _process(delta: float) -> void:
	pass
