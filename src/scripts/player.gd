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

var interactingWithObj

func _ready() -> void:
	GameManager.playerCamera = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		updateCameraMotion(event)
		checkInteractRay()
	
	handleObjectInteractions(event)
	handlePlayerMovement()
	
	# add input here to exit chair camera view at the helm and handle the helm input


func updateCameraMotion(event) -> void:
	mouse_motion = event.relative
	playerCameraPivot.rotation.y -= mouse_motion.x * camera_sensitivity
	playerCameraPivot.rotation.x -= mouse_motion.y * camera_sensitivity
	playerCameraPivot.rotation.x = clamp(playerCameraPivot.rotation.x, deg_to_rad(-camera_look_angle_max), deg_to_rad(camera_look_angle_max))


# if the player is looking at something interactable and they press "interact" then they activate the interactable
# interaction behavior is handled by the object itself
func handleObjectInteractions(event):
	if interactingWithObj: # don't bother processing if there is no interactable
		if interactingWithObj.get_parent().has_method("interact"):
			setInteractionHint(interactingWithObj.get_parent().interactHintText, interactingWithObj.get_parent().name) 
			if event.is_action_pressed("interact"):
				if interactingWithObj:
					interactingWithObj.get_parent().interact()
			elif event.is_action_pressed("alt_interact"):
				if interactingWithObj:
					interactingWithObj.get_parent().alt_interact()
		else:
			setInteractionHint("", "")
	else:
		setInteractionHint("", "")

func setInteractionHint(hintText, nameText):
	get_tree().root.get_node("main3D/mainUI/interactHint").text = hintText
	get_tree().root.get_node("main3D/mainUI/interactNameHint").text = "[center]" + nameText + "[/center]"

func handlePlayerMovement():
	# Player jumping
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Player movement
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = (playerCameraPivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
func checkInteractRay():
	# check if player raycast is colliding with stuff
	if $cameraPivot/interactCast.is_colliding():
		interactingWithObj = $cameraPivot/interactCast.get_collider()
		print("Can interact with: ", interactingWithObj.name)
		# do some updating here to allow interaction and UI updating
	else:
		interactingWithObj = null
