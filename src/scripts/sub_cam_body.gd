extends CharacterBody3D

var radarRotationSpeed:float = 180.0


func _physics_process(delta: float) -> void:
	move_and_slide()
	
	
	$radarScanner.rotation.y += deg_to_rad(radarRotationSpeed) * delta


func _on_collect_area_area_entered(area: Area3D) -> void:
	print("area entered: ", area.owner.name)
	if area.owner.has_method("bubble"):
		# show collect bubble interact hint
		print("found a bubble.")
		GameManager.interactHint.text = "[center]Press [E] to collect the oxygen bubble.[/center]"
		GameManager.interactNameHint.text = "[center]Bubble [E] to collect.[/center]"
		GameManager.subInteractTarget = area.owner
	if area.owner.name==("goldenBubble"):
		GameManager.endGame()


func _on_collect_area_area_exited(area: Area3D) -> void:
	return


func _on_collect_area_body_entered(body: Node3D) -> void:
	if body.owner:
		print("Collided with: ", body.owner.name)
		if body.owner.name == "Walls": # handles collisions with walls
			GameManager.endGame()
