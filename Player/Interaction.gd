extends Node3D

class_name Interaction

@onready var camera = get_tree().get_first_node_in_group("Camera")
@onready var bone_attachment: BoneAttachment3D = $"../Body/Armature/Skeleton3D/BoneAttachment3D"

var placer_height: float = 0.0
var mouse_position
var field: Field
var player: Player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()
	
	
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
func harvest():
	var plant = get_plant()
	print(plant)
	if plant != null:
		var mesh = plant.growth_stages[plant.get_level()]
		if field.has_harvestable_plant:
			mesh.reparent(bone_attachment)
			mesh.position = plant.get_carrying_position()
			mesh.rotation_degrees = plant.get_carrying_rotation()
			player.carrying_weight = get_weight(plant.get_level())

func get_plant() -> Plant:
	for child in field.get_children():
		if child is Plant:
			return child
	return null
	
func get_weight(level : int) -> Player.Weight:
	if level == 2:
		return Player.Weight.light
	elif level == 3:
		return Player.Weight.medium
	elif level == 4:
		return Player.Weight.heavy
	else:
		return Player.Weight.none

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
	
	
		
