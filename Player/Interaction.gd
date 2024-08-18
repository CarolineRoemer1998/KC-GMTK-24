extends Node3D

class_name Interaction

@onready var camera = get_tree().get_first_node_in_group("Camera")

var placer_height: float = 0.0
var mouse_position
var field: Field
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if Input.is_action_just_pressed("T_Small"):
		#
	#if Input.is_action_just_pressed("T_Med"):
		#var new_field_placer_medium = field_placer_medium .instantiate()
		#add_child(new_field_placer_medium)
	#if Input.is_action_just_pressed("T_Large"):
		#var new_field_placer_large = field_placer_large.instantiate()
		#add_child(new_field_placer_large)
		

func calculate_camera_ray():
	mouse_position = get_viewport().get_mouse_position()
	
	# Get the ray origin and direction from the camera
	var ray_origin = camera.project_ray_origin(mouse_position)
	var ray_direction = camera.project_ray_normal(mouse_position)
	
	# Calculate the distance to the fixed Y plane
	var distance = (placer_height - ray_origin.y) / ray_direction.y
	
	# Calculate the intersection point on the Y plane
	var intersection_point = ray_origin + ray_direction * distance
	return intersection_point
	
	
		
