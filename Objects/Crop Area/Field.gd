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

# Called when the node enters the scene tree for the first time.
func _ready():
	#set_plant_offset()
	is_chosen = false
	print(name, is_chosen)
	is_occupied = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("T_Plant") && is_chosen && !is_occupied:
		plant_seed()

func plant_seed():
	Global.lose_energy(energy_cost)
	is_occupied
	var new_plant = plant.instantiate()
	add_child(new_plant)
	#new_plant.global_position += plant_offset
	

#func set_plant_offset():
	#if size == field_size.small:
		#plant_offset = Vector3(0,0,0)
	#if size == field_size.medium:
		#plant_offset = Vector3(0.5,0,0.5)
	#if size == field_size.large:
		#plant_offset = Vector3(1,0,1)
		

