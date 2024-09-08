extends Node3D

class_name  Field_Placer

enum placer_size {small, medium, large}

@onready var mesh_instance_3d = $MeshInstance3D

@export var field_small: PackedScene
@export var field_medium: PackedScene
@export var field_large: PackedScene
@export var size: placer_size


var placer_color_neutral = preload("res://Colors/field_placer_neutral.tres")
var placer_color_free = preload("res://Colors/field_placer_free.tres")
var placer_color_occupied = preload("res://Colors/field_placer_occupied.tres")

var player: Player 
var needed_empty_colliders
var mouse_position
var parent
var placer_height: float = 0.0
var active_colliders: Array = []
var has_placed: bool = false

var camera: Camera3D
var camera_original_position
var camera_original_rotation_degrees 

var energy_bar

@onready var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	energy_bar = get_tree().get_first_node_in_group("EnergyBar")
	player = get_tree().get_first_node_in_group("Player")
	timer = get_tree().get_first_node_in_group("Timer") 
	camera = get_tree().get_first_node_in_group("Camera") 
	energy_bar.hide()
	shop_camera_activate()
	if size == placer_size.small:
		needed_empty_colliders = 1
	if size == placer_size.medium:
		needed_empty_colliders = 4
	if size == placer_size.large:
		needed_empty_colliders = 9
	
	parent = get_parent()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if parent is Interaction:
		var intersection_point = parent.calculate_camera_ray()
		move_object_to_mouse(intersection_point)
	if Input.is_action_just_pressed("T_Place") && active_colliders.size() == needed_empty_colliders:
		place_field()
		
	if active_colliders.size() == needed_empty_colliders:
		mesh_instance_3d.material_override = placer_color_free
	if active_colliders.size() != needed_empty_colliders:
		if active_colliders.size() == 0:
			mesh_instance_3d.material_override = placer_color_neutral
		else:
			mesh_instance_3d.material_override = placer_color_occupied
	
func move_object_to_mouse(intersection_point):
	# Update the object's X and Z positions, and keep Y fixed
	global_transform.origin.x = intersection_point.x
	global_transform.origin.z = intersection_point.z
	global_transform.origin.y = placer_height  # Keep Y constant
	

func _on_area_3d_area_entered(area):
	active_colliders.append(area)
	
func _on_field_detector_area_exited(area):
	active_colliders.erase(area)
	
func place_field():
	if has_placed == false:

		if size == placer_size.small:
			has_placed = true
			var new_field_small = field_small.instantiate()
			add_sibling(new_field_small)
			new_field_small.global_position = calculate_middlepoint()
			new_field_small.top_level = true
			
			
		if size == placer_size.medium:
			has_placed = true
			var new_field_medium = field_medium.instantiate()
			add_sibling(new_field_medium)
			calculate_middlepoint()
			new_field_medium.global_position = calculate_middlepoint()
			new_field_medium.top_level = true
			
			
		if size == placer_size.large:
			has_placed = true
			var new_field_large = field_large.instantiate()
			add_sibling(new_field_large)
			new_field_large.global_position = calculate_middlepoint()
			new_field_large.top_level = true
			
		for collider in active_colliders:
			collider.get_parent().queue_free()
		timer.start()
	
	
func calculate_middlepoint():
	var midpoint_x = 0.0
	var midpoint_z = 0.0
	var midpoint = Vector3(0,0,0)
	
	if size == placer_size.small:
		print("size small")
		
		for collider in active_colliders:
			midpoint_x = midpoint_x + collider.global_position.x
			midpoint_z =  midpoint_z + collider.global_position.z
		midpoint.x = midpoint_x / 1
		midpoint.z = midpoint_z / 1
		return midpoint
		
	if size == placer_size.medium:
		
		for collider in active_colliders:
			midpoint_x = midpoint_x + collider.global_position.x
			midpoint_z =  midpoint_z + collider.global_position.z
		midpoint.x = midpoint_x / 4
		midpoint.z = midpoint_z / 4
		return midpoint
		
	if size == placer_size.large:
		for collider in active_colliders:
			midpoint_x = midpoint_x + collider.global_position.x
			midpoint_z =  midpoint_z + collider.global_position.z
		midpoint.x = midpoint_x / 9
		midpoint.z = midpoint_z / 9
		return midpoint

func shop_camera_activate():

	camera.toggle_camera_offset()
	camera.global_position = Vector3(0,19,2.25)
	camera.rotation_degrees = Vector3(-90, 0, 0)
	player.can_move = false

func shop_camera_deactivate():
	camera.toggle_camera_offset()
	player.can_move = true
	energy_bar.show()
	queue_free()
