extends Node3D

var t = 0.0
var current_position : Vector3
var new_position : Vector3
var is_moving : bool = false

func _process(delta: float) -> void:
	if is_moving:
		move_to_chest(delta)

func move_to_chest(delta: float):
	t += delta*2
	current_position = global_position
	
	global_position = current_position.lerp(new_position, t)
	if global_position.distance_to(new_position) < 0.1:
		t=0.0
		current_position = new_position
		player.is_active = true
