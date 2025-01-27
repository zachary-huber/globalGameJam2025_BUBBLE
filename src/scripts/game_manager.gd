extends Node

var timePlayed:float = 0 # This keeps track of time played during the game
var score # This might hold some kind of score value
var seedString:String # This is a value players can enter at the menu to set the random seed manually
var rng = RandomNumberGenerator.new() # This generates random numbers

var currrentRotation:float
var currentVelocity:float
var o2:float = 85
var shipHealth:float = 20
var bubbleCollected:int = 0
var timeLookStart = null

var theWheel = null
var theLever = null
var interactHint = null
var interactNameHint = null
var subInteractTarget = null
var xCoord = null
var yCoord = null
var o2Label = null
var needle = null
var speedLabel = null

var isAtHelm = false
var isPeeping = false
var playerCamera = null
var chairCamera = null
var subCam = null

var peepholeTexture = null
var subCamViewport = null
var jumpscareTexture = null
var jumpscareTexture2 = null

var isPaused:bool = false
var pauseMenu = null
var isScaryHappening = false

var waterLeak = null
var waterLeak2 = null
var waterLeak3 = null

var redLight = null
var ohShit = null

var Dead = null

var timeUntilJumpscare:float = 5.0 # if we look out the peephole this long, scary things happen

func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _ready() -> void:
	rng.seed = hash(seedString)
	#var my_random_number = rng.randf_range(-10.0, 10.0)


func _process(delta: float) -> void:
	
	if theWheel and theLever:
		currrentRotation = theWheel.rotation.x
		currentVelocity = remap(-theLever.position.x, 1.34, 1.72, 0,1) +8.05

func _input(event: InputEvent) -> void:
	pass


func _on_timer_timeout() -> void:
	timePlayed += 0.25
	o2 -= 0.02
	
	if o2 < 25:
		AudioManager.oxygenAlarm.play()
	else:
		AudioManager.oxygenAlarm.stop()
	
	#print("rotation: ", currrentRotation)
	#print("velocity: ", currentVelocity)
	
	get_tree().root.get_node("main3D/mainUI/VBoxContainer/debugInfo").text  = \
	"Rotation: " + str(currrentRotation).pad_decimals(2) + '\n' + \
	"Velocity: " + str(currentVelocity).pad_decimals(2) + '\n' + \
	"Ship Health: " + str(shipHealth).pad_decimals(0) + '\n' + \
	"O2: " + str(o2).pad_decimals(2) + '\n' + \
	"Time: " + str(timePlayed).pad_decimals(0) + '\n' + \
	"Bubbles Found: " + str(bubbleCollected) + "\n" + \
	"isPeeping: " + str(isPeeping) + "\n"
	
	updateSubCam()
	
	xCoord.text = "X:" + str(subCam.position.x).pad_decimals(2)
	yCoord.text = "Y:" + str(subCam.position.z).pad_decimals(2)
	
	o2Label.text = "O2: " + str(o2) + "%"
	needle.rotation.y = currrentRotation
	speedLabel.text = str(clamp(currentVelocity * 100, 0, 100) + .3).pad_decimals(0)+ "%"
	
	if GameManager.isPeeping and $jumpscareCooldown.is_stopped():
		print("Peep time: ", GameManager.timePlayed - GameManager.timeLookStart)
		print("timeLookStart: ", GameManager.timeLookStart)
		print("timePlayed: ", GameManager.timePlayed)
		if GameManager.timePlayed - GameManager.timeLookStart > timeUntilJumpscare:
			print("You looked TOO LONG!")
			$jumpscareCooldown.start()
			GameManager.doScaryThing()

func updateSubCam():
	subCam.velocity = subCam.basis * Vector3.RIGHT * -currentVelocity
	subCam.rotation.y = currrentRotation
	
	print(subCam.velocity)

func extractBubble():
	if GameManager.subInteractTarget:
		if GameManager.subInteractTarget.has_method("bubble"):
			GameManager.subInteractTarget.collectBubble()
			GameManager.subInteractTarget = null

func doScaryThing():
	if !GameManager.isScaryHappening:
		GameManager.isScaryHappening = true
		randomize()
		var r = GameManager.rng.randi_range(0,2)
		#AudioManager.alarmSound.play()
		waterLeak.visible = true
		waterLeak2.visible = true
		waterLeak3.visible = true
		redLight.play("redLight")
		
		
		match r:
			0: 
				#AudioManager.alarmSound.play()
				pass # scary sound (alarm)
			1: 
				GameManager.jumpscareTexture.visible = true
				$jumpscareDuration.start()
				pass # monster jump scare 1
			2: 
				GameManager.jumpscareTexture2.visible = true
				$jumpscareDuration.start()
				pass # monster jump scare 2
			_: 
				print("This should not happen... but we will re-roll the scary thing")
				doScaryThing()
		print("Rolled [r] as: ", r)

func startLore():
	#$Timer.start()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().change_scene_to_file("res://src/scenes/lore.tscn")

func startGame():
	get_tree().change_scene_to_file("res://src/scenes/main_3d.tscn")

func endGame():
	Dead.play("dead")
	print("Found the golden bubble!!! -> Game end!")


func _on_jumpscare_duration_timeout() -> void:
	GameManager.jumpscareTexture.visible = false
	GameManager.jumpscareTexture2.visible = false
	waterLeak.visible = false
	waterLeak2.visible = false
	waterLeak3.visible = false
