extends StaticBody3D

class_name Field
enum field_size {small, medium, large}
@export var max_level: int 
@export var size: field_size
@export var plant: PackedScene
@export var energy_cost: int = 1
var plant_offset : Vector3

var is_chosen: bool 
var is_occupied: bool

# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
@onready var mesh: MeshInstance3D
var color_unwatered = preload("res://Colors/watering_state_unwatered.tres")
var color_watered = preload("res://Colors/watering_state_watered.tres")

var plant_is_watered : bool = false
var has_harvestable_plant : bool = false

func set_watered(is_watered : bool):
	if is_watered:
		mesh.material_override = color_watered
		plant_is_watered = true
	else:
		mesh.material_override = color_unwatered
		plant_is_watered = false
	
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	#set_plant_offset()
	is_chosen = false
	is_occupied = false
	# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	for child in get_children():
		if child.name == "field":
			for _mesh in child.get_children():
				mesh = _mesh

	# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("T_Plant") && is_chosen && !is_occupied:
		plant_seed()
		print("planting...")

func reset():
	set_watered(false)
	is_occupied = false
	has_harvestable_plant = false

func plant_seed():
	Global.lose_energy(energy_cost)
	is_occupied = true
	var new_plant = plant.instantiate()
	add_child(new_plant)
	new_plant.global_position += Vector3(0,0.25,0)
	

#func set_plant_offset():
	#if size == field_size.small:
		#plant_offset = Vector3(0,0,0)
	#if size == field_size.medium:
		#plant_offset = Vector3(0.5,0,0.5)
	#if size == field_size.large:
		#plant_offset = Vector3(1,0,1)
		

