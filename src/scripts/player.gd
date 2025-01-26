extends CharacterBody3D


const SPEED = 2.0
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


enum Direction {
	FORWARD,
	LEFT,
	RIGHT,
	BACKWARD
	}

var last_direction : Direction = Direction.FORWARD
var currentDir : Direction = Direction.FORWARD
var rotationDirection = 0 # positive for clockwise and negative for counterclockwise

var direction_map : Dictionary = {
	Direction.FORWARD: {
		Direction.RIGHT: 1,
		Direction.LEFT: -1,
		Direction.BACKWARD: 0
	},
	Direction.LEFT: {
		Direction.FORWARD: 1,
		Direction.BACKWARD: -1,
		Direction.RIGHT: 0
	},
	Direction.RIGHT: {
		Direction.FORWARD: -1,
		Direction.BACKWARD: 1,
		Direction.LEFT: 0
	},
	Direction.BACKWARD: {
		Direction.FORWARD: 0,
		Direction.RIGHT: -1,
		Direction.LEFT: 1
	}
}


func _ready() -> void:
	GameManager.playerCamera = $cameraPivot/Camera3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	# add input here to exit chair camera view at the helm and handle the helm input
	if GameManager.isAtHelm:
		setInteractionHint("[center]Move mouse up and down to go forward. [WASD] to Steer.[/center]", "")
		if event.is_action_pressed("escape"):
			# exit the helm mode
			GameManager.isAtHelm = false
			GameManager.playerCamera.current = true
		else: # handle wheel and lever controls
			# handle wheel movement
			currentDir
			# update currentDir with WASD
			if Input.is_action_just_pressed("left"):
				currentDir = Direction.LEFT
				rotationDirection = get_rotation_direction(currentDir)
				GameManager.theWheel.rotation.x -= (rotationDirection * deg_to_rad(10.0))
				print(rotationDirection)
			elif Input.is_action_just_pressed("forward"):
				currentDir = Direction.FORWARD
				rotationDirection = get_rotation_direction(currentDir)
				GameManager.theWheel.rotation.x -= (rotationDirection * deg_to_rad(10.0))
				print(rotationDirection)
			elif Input.is_action_just_pressed("right"):
				currentDir = Direction.RIGHT
				rotationDirection = get_rotation_direction(currentDir)
				GameManager.theWheel.rotation.x -= (rotationDirection * deg_to_rad(10.0))
				print(rotationDirection)
			elif Input.is_action_just_pressed("backward"):
				currentDir = Direction.BACKWARD
				rotationDirection = get_rotation_direction(currentDir)
				GameManager.theWheel.rotation.x -= (rotationDirection * deg_to_rad(10.0))
				print(rotationDirection)
			GameManager.subCam.rotation.y = GameManager.currrentRotation
			
			# handle lever movement
			if event is InputEventMouseMotion:
				# get mouse vertical movement
				mouse_motion = event.relative
				var mouseY = mouse_motion.y * -GameManager.theLever.leverSensitivity
				
				# apply that to the leverPart
				GameManager.theLever.position.x += mouseY
				GameManager.theLever.position.x = clamp(GameManager.theLever.position.x, 1.34, 1.72)
	elif GameManager.isPeeping:
		# handle the peephole controls
		if event.is_action_pressed("escape"):
			GameManager.isPeeping = false
			GameManager.subCamViewport.visible = false
			GameManager.peepholeTexture.visible = false
			
			GameManager.isPaused = false
			GameManager.pauseMenu.visible = false
			
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
		elif event.is_action_pressed("interact"):
			if GameManager.subInteractTarget:
				if GameManager.subInteractTarget.has_method("bubble"):
					GameManager.subInteractTarget.collectBubble()
					GameManager.subInteractTarget = null
	else:  # we are not at the helm or peephole
		if event is InputEventMouseMotion:
			updateCameraMotion(event)
			checkInteractRay()
		if event.is_action_pressed("escape"):
			GameManager.isPaused = !GameManager.isPaused
			GameManager.pauseMenu.visible = GameManager.isPaused
			
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			if GameManager.isPaused: Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
	handleObjectInteractions(event)
	handlePlayerMovement()
	
	if event.is_action_pressed("scaryTest"):
		print("Testing Scary things...")
		GameManager.doScaryThing()


func updateCameraMotion(event) -> void:
	mouse_motion = event.relative
	playerCameraPivot.rotation.y -= mouse_motion.x * camera_sensitivity
	playerCameraPivot.rotation.x -= mouse_motion.y * camera_sensitivity
	playerCameraPivot.rotation.x = clamp(playerCameraPivot.rotation.x, deg_to_rad(-camera_look_angle_max), deg_to_rad(camera_look_angle_max))


# if the player is looking at something interactable and they press "interact" then they activate the interactable
# interaction behavior is handled by the object itself
func handleObjectInteractions(event):
	if GameManager.isAtHelm:
		GameManager.interactHint.text = "[center]Move mouse up and down to go forward. [WASD] to Steer.[/center]"
		setInteractionHint("[center]Move mouse up and down to go forward. [WASD] to Steer.[/center]", "")
	else:
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
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
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


# Function to determine the rotation direction
func get_rotation_direction(current_direction: Direction) -> int:
	# Safely access the direction_map, with default value of 0 if not found
	var direction = direction_map.get(last_direction, {}).get(current_direction, 0)
	last_direction = current_direction
	return direction

func player():
	pass
