extends Control


func _ready() -> void:
	GameManager.subCam = $SubViewportContainer/SubViewport/subCamBody
	GameManager.subCamViewport = self
	GameManager.peepholeTexture = $"../peephole"

func _process(delta: float) -> void:
	$topDownView/SubViewport/Camera3D.global_position = $SubViewportContainer/SubViewport/subCamBody.global_position + Vector3(4.2, 13.3, 0.0)
