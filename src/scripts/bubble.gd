extends Node3D


enum BUBBLE_TYPE {
	BLUE,
	GOLDEN
}

var bubbleType = BUBBLE_TYPE.BLUE
var oxygenValue:float = 5.0 # potentially make this random

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func bubble():
	pass

func collectBubble():
	# increases current o2 value by the value the bubble contains
	GameManager.o2 += oxygenValue
	
	self.call_deferred("queue_free")
