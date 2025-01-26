extends Node3D

@export var fishType: Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GPUParticles3D.draw_pass_1 = fishType
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
