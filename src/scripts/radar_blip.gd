extends Node3D

@export var lifespanSeconds = 3.0

func _ready():
	$lifespanTimer.wait_time = lifespanSeconds
	#$lifespanTimer.start()


func _process(delta):
	pass


func appear():
	visible = true
	$lifespanTimer.start()

func _on_lifespan_timer_timeout():
	visible = false
	#self.call_deferred("queue_free")
