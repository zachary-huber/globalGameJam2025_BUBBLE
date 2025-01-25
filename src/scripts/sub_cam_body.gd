extends CharacterBody3D

var radarRotationSpeed:float = 15.0


func _physics_process(delta: float) -> void:
	move_and_slide()
	
	
	$radarScanner.rotation.y += deg_to_rad(radarRotationSpeed) * delta
