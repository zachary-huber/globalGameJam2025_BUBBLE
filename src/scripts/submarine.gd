extends Node3D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameManager.xCoord = $xCoord
	GameManager.yCoord = $yCoord
	GameManager.o2Label = $o2Label
	GameManager.needle = $Node3D/needle
	GameManager.speedLabel = $speedLabel
	
	GameManager.get_node("Timer").start()
	
	GameManager.waterLeak = $waterLeak
	GameManager.waterLeak2 = $waterLeak2
	GameManager.waterLeak3 = $waterLeak3
	GameManager.redLight = $AnimationPlayer
	#AudioManager.ambienceHum.play()
	#AudioManager.ambienceWater.play()
	#AudioManager.ambiencePing.play()

func _process(delta: float) -> void:
	pass
