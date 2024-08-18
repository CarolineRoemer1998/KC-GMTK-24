extends Node3D

class_name  Field_Placer

enum placer_size {small, medium, large}

@export var size: placer_size
var needed_empty_colliders
var mouse_position
var parent
var placer_height: float = 0.0
var active_colliders: Array = []
# Called when the node enters the scene tree for the first time.
func _ready():
	if size == placer_size.small:
		needed_empty_colliders = 1
	if size == placer_size.small:
		needed_empty_colliders = 4
	if size == placer_size.small:
		needed_empty_colliders = 9
	parent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if parent is Interaction:
		var intersection_point = parent.calculate_camera_ray()
		move_object_to_mouse(intersection_point)
	if Input.is_action_just_pressed("T_Place") && active_colliders.size() == needed_empty_colliders:
		place_field()
	
func move_object_to_mouse(intersection_point):
	# Update the object's X and Z positions, and keep Y fixed
	global_transform.origin.x = intersection_point.x
	global_transform.origin.z = intersection_point.z
	global_transform.origin.y = placer_height  # Keep Y constant
	

func _on_area_3d_area_entered(area):
	active_colliders.append(area)
	print(active_colliders.size())
	
func _on_field_detector_area_exited(area):
	active_colliders.erase(area)
	print(active_colliders.size())
	
func place_field():
		print("Platziere Feld")


