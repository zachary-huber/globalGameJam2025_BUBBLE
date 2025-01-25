extends Control


func _ready() -> void:
	GameManager.subCam = $SubViewportContainer/SubViewport/subCamBody


func _process(delta: float) -> void:
	pass
