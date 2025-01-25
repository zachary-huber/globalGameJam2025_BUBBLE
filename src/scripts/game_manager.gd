extends Node

var timePlayed # This keeps track of time played during the game
var score # This might hold some kind of score value
var seedString:String # This is a value players can enter at the menu to set the random seed manually
var rng = RandomNumberGenerator.new() # This generates random numbers


func _ready() -> void:
	rng.seed = hash(seedString)
	#var my_random_number = rng.randf_range(-10.0, 10.0)


func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	timePlayed += 1
