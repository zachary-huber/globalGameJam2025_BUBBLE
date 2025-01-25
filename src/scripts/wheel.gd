extends Interactable

@export var rotationSpeed:float = 15.0

func _init() -> void:
	interactHintText = "[center]Sit at chair to steer.[/center]"

func _ready() -> void:
	GameManager.theWheel = $StaticBody3D/wheelSpinPart # create a reference to this wheel so the game manager can manage it
	print(GameManager.theWheel)

func _process(delta: float) -> void:
	pass

func rotateWheel(direction:String):
	if direction == "right":
		$StaticBody3D/wheelSpinPart.rotation.y -= deg_to_rad(rotationSpeed)
	elif direction == "left":
		$StaticBody3D/wheelSpinPart.rotation.y += deg_to_rad(rotationSpeed)

#
#func interact():
	#super()
	#rotateWheel("right")
#
#func alt_interact():
	#super()
	#rotateWheel("left")
