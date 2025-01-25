extends Node3D

@export var rotationSpeed:float = 2.0

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func rotateWheel(direction:String):
	if direction == "right":
		$StaticBody3D/wheelSpinPart.rotation.y += rotationSpeed
	elif direction == "left":
		$StaticBody3D/wheelSpinPart.rotation.y -= rotationSpeed
