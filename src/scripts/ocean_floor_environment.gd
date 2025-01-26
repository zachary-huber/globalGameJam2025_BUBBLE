extends Node3D

var offset = Vector3.ZERO
@onready var mesh_instance = $StaticBody3D/MeshInstance3D
@onready var noise_texture : NoiseTexture2D = $StaticBody3D/MeshInstance3D.material_override.albedo_texture

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	offset += Vector3(0.1, 0.1, 0) * delta
	
	if mesh_instance.material_override and mesh_instance.material_override is ShaderMaterial:
		var material = mesh_instance.material_override as ShaderMaterial
		material.set_shader_param("noise_offset", offset)
