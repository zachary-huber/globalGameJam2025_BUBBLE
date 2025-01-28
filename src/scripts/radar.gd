extends Node3D


@export var rotationSpeed:float = 1.5
@export var scanSpeed:float = 0.001
var collidedObject
var collisionPoint
var radarBlip = preload("res://src/scenes/radar_blip.tscn")

var numBlips:int = 1000
var blipPool = []
var blipIndex = 0

var currentTick = 0
var lastTick = 0
var tickDifferenceMax = 0.0001


func _init():
	pass

func _ready():
	$checkCollisionsTimeout.wait_time = scanSpeed
	$checkCollisionsTimeout.start()
	
	# assemble the blip pool
	for i in numBlips:
		var newBlip = radarBlip.instantiate()
		blipPool.append(newBlip)
		get_tree().root.add_child.call_deferred(newBlip)
		
	#print(blipPool)

func _physics_process(delta):
	self.rotation.y += rotationSpeed * delta
	


func _process(delta):
	# custom timer
	lastTick = currentTick
	currentTick = Time.get_ticks_msec()
	
	#print("tick dif:",currentTick - lastTick)w
	
	if(currentTick - lastTick > tickDifferenceMax):
		checkCollision() # timer action


# have to write my own timer, since default timers are no good for short timespans... :/
func _on_check_collisions_timeout_timeout():
	#checkCollision()
	pass


func spawnBlip(point):
	var newBlip = radarBlip.instantiate()
	get_tree().root.add_child(newBlip)
	newBlip.global_position = point


func placeBlip(point):
	blipPool[blipIndex].global_position = point
	blipPool[blipIndex].appear()
	blipIndex = (blipIndex + 1) % blipPool.size()


func spawnBlip_old(point): # preinstance 100 blips into a pool and then just move them as needed == speedup!!!
	var newBlip = radarBlip.instantiate()
	newBlip.global_position = point
	get_tree().root.add_child(newBlip)


func checkCollision():
	if $RayCast3D.is_colliding():
		collidedObject = $RayCast3D.get_collider()
		collisionPoint = $RayCast3D.get_collision_point()
		#spawnBlip(collisionPoint)
		placeBlip(collisionPoint)
