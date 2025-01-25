extends Interactable

func _init() -> void:
	interactHintText = "[center]Move mouse [up] and [down] to move forward and back[/center]"

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func interact():
	super()

func alt_interact():
	super()
