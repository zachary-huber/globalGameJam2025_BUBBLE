class_name Interactable
extends Node

@export var interactHintText:String = "[center]This is the default interact hint![/center]"


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func interact():
	print("interacting with ", self)

func alt_interact():
	print("alt_interacting with ", self)
