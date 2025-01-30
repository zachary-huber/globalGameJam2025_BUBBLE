extends MeshInstance3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y = GameManager.o2
	position.y = remap(GameManager.o2,0,100, -1.028, 0.219)
	pass
