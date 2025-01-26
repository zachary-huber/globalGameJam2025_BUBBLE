extends Control



func _ready() -> void:
	GameManager.interactHint = $interactHint
	GameManager.interactNameHint = $interactNameHint
	GameManager.pauseMenu = $pauseMenu
	GameManager.jumpscareTexture = $jumpscareTexture
	GameManager.jumpscareTexture2 = $jumpscareTexture2

func _process(delta: float) -> void:
	pass


func _on_quit_button_button_down() -> void:
	get_tree().quit()


func _on_resume_button_button_down() -> void:
	GameManager.isPaused = false
	GameManager.pauseMenu.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
