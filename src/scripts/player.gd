extends CharacterBody3D


const SPEED = 5.0
const RUN_SPEED = 6.0
const JUMP_VELOCITY = 4.5

# camera vars
var camera_sensitivity:float = 0.002 #y axis
var camera_look_angle_min:float = -89
var camera_look_angle_max:float = 89
var mouse_motion:Vector2 = Vector2.ZERO

var input_dir
var direction

@onready var playerCameraPivot = $cameraPivot

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		updateCameraMotion(event)
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = (playerCameraPivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


func updateCameraMotion(event) -> void:
	mouse_motion = event.relative
	playerCameraPivot.rotation.y -= mouse_motion.x * camera_sensitivity
	playerCameraPivot.rotation.x -= mouse_motion.y * camera_sensitivity
	playerCameraPivot.rotation.x = clamp(playerCameraPivot.rotation.x, deg_to_rad(-camera_look_angle_max), deg_to_rad(camera_look_angle_max))
