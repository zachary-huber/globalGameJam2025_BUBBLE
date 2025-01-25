extends Node

var timePlayed:float = 0 # This keeps track of time played during the game
var score # This might hold some kind of score value
var seedString:String # This is a value players can enter at the menu to set the random seed manually
var rng = RandomNumberGenerator.new() # This generates random numbers

var currrentRotation:float
var currentVelocity:float
var o2:float
var shipHealth:float
var bubbleCollected:int = 0

var theWheel = null
var theLever = null
var interactHint = null
var interactNameHint = null
var subInteractTarget = null
var xCoord = null
var yCoord = null

var isAtHelm = false
var isPeeping = false

var playerCamera = null
var chairCamera = null
var subCam = null

var peepholeTexture = null
var subCamViewport = null


func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _ready() -> void:
	rng.seed = hash(seedString)
	#var my_random_number = rng.randf_range(-10.0, 10.0)


func _process(delta: float) -> void:
	
	if theWheel and theLever:
		currrentRotation = theWheel.rotation.x
		currentVelocity = remap(-theLever.position.x, 1.34, 1.72, 0,1) +8.05


func _on_timer_timeout() -> void:
	timePlayed += 1
	
	print("rotation: ", currrentRotation)
	print("velocity: ", currentVelocity)
	
	get_tree().root.get_node("main3D/mainUI/VBoxContainer/debugInfo").text  = \
	"Rotation: " + str(currrentRotation).pad_decimals(2) + '\n' + \
	"Velocity: " + str(currentVelocity).pad_decimals(2) + '\n' + \
	"Ship Health: " + str(shipHealth) + '\n' + \
	"O2: " + str(o2) + '\n' + \
	"Time: " + str(timePlayed) + '\n' + \
	"Bubbles Found: " + str(bubbleCollected) + "\n"
	
	updateSubCam()
	
	xCoord.text = "X:" + str(subCam.position.x).pad_decimals(2)
	yCoord.text = "Y:" + str(subCam.position.z).pad_decimals(2)

func updateSubCam():
	subCam.velocity = subCam.basis * Vector3.RIGHT * -currentVelocity
	subCam.rotation.y = currrentRotation
	
	print(subCam.velocity)
