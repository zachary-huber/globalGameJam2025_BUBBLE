extends Control


func _ready() -> void:
	AudioManager.musicPlayer.play()


func _process(delta: float) -> void:
	pass


func _on_start_button_button_down() -> void:
	GameManager.startLore()

func _on_quit_button_button_down() -> void:
	get_tree().quit()


func _on_credits_button_button_down() -> void:
	$credits.visible = !$credits.visible
	$credits2.visible = !$credits2.visible
