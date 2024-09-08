extends Node3D

@export var timer_length: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = true
	timer.connect("timeout", _on_timer_timeout)
	timer.start(timer_length)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	queue_free()
