extends Node3D

@export var rotationSpeed:float = 15.0

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func rotateWheel(direction:String):
	if direction == "right":
		$StaticBody3D/wheelSpinPart.rotation.y -= deg_to_rad(rotationSpeed)
	elif direction == "left":
		$StaticBody3D/wheelSpinPart.rotation.y += deg_to_rad(rotationSpeed)


func interact():
	rotateWheel("right")

func alt_interact():
	rotateWheel("left")
