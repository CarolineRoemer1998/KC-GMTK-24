extends Node3D

class_name Interaction

@onready var camera = get_tree().get_first_node_in_group("Camera")
@onready var bone_attachment: BoneAttachment3D = $"../Body/Armature/Skeleton3D/BoneAttachment3D"

var placer_height: float = 0.0
var mouse_position
var field: Field
var player: Player

# Harvested Plant handling
var carrying_plant : Plant
var t = 0.0
var current_position : Vector3
var new_position : Vector3
var is_throwing : bool = false
var in_front_of_chest : bool = false
var chest_position : Vector3

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
			plant.reparent(bone_attachment)
			#print(mesh.name, mesh. )
			carrying_plant = plant
			plant.position = plant.get_carrying_position()
			plant.rotation_degrees = plant.get_carrying_rotation()
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

func store_plant(delta : float):
	t += delta*2
	print("throwing...")
	current_position = carrying_plant.global_position
	new_position = chest_position
	carrying_plant.global_position = carrying_plant.global_position.lerp(chest_position, t)
	if carrying_plant.global_position.distance_to(chest_position) < 0.1:
		t=0.0
		current_position = new_position
		is_throwing = false
	

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_throwing:
		store_plant(delta)
	
		

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
	
	
		
