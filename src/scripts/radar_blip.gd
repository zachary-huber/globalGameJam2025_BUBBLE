extends Node3D

@export var lifespanSeconds = 1.0

func _ready():
	$lifespanTimer.wait_time = lifespanSeconds
	$lifespanTimer.start()


func _process(delta):
	pass


func _on_lifespan_timer_timeout():
	self.call_deferred("queue_free")
