extends Node3D


@export var rotationSpeed:float = 1.5
@export var scanSpeed:float = 0.001
var collidedObject
var collisionPoint
var radarBlip = preload("res://src/scenes/radar_blip.tscn")

var numBlips:int = 100
var blipPool = []


func _init():
	pass

func _ready():
	$checkCollisionsTimeout.wait_time = scanSpeed
	$checkCollisionsTimeout.start()
	
	# assemble the blip pool
	for i in numBlips:
		blipPool.append(radarBlip.instantiate())


func _process(delta):
	#self.rotation.y = fmod(self.rotation.y + (rotationSpeed * delta), 360.0)
	checkCollision()
	self.rotation.y += rotationSpeed * delta


# have to write my own timer, since default timers are no good for short timespans... :/
func _on_check_collisions_timeout_timeout():
	pass


func spawnBlip(point):
	pass


func spawnBlip_old(point): # preinstance 100 blips into a pool and then just move them as needed == speedup!!!
	var newBlip = radarBlip.instantiate()
	newBlip.global_position = point
	get_tree().root.add_child(newBlip)


func checkCollision():
	if $RayCast3D.is_colliding():
		collidedObject = $RayCast3D.get_collider()
		collisionPoint = $RayCast3D.get_collision_point()
		spawnBlip(collisionPoint)
