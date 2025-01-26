extends Node3D


func _ready() -> void:
	GameManager.xCoord = $xCoord
	GameManager.yCoord = $yCoord
	GameManager.o2Label = $o2Label
	GameManager.needle = $Node3D/needle
	GameManager.speedLabel = $speedLabel
	
	AudioManager.ambienceHum.play()
	AudioManager.ambienceWater.play()
	AudioManager.ambiencePing.play()

func _process(delta: float) -> void:
	pass
