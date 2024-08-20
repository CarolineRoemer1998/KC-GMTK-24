extends StaticBody3D

class_name Field
enum field_size {small, medium, large}
@export var max_level: int 
@export var size: field_size
@export var plant: PackedScene
@export var energy_cost: int = 1
var plant_offset : Vector3

@export var weed_small : PackedScene
@export var weed_medium : PackedScene
@export var weed_large : PackedScene

var is_chosen: bool 
var is_occupied: bool

var rand_weed
var has_weed : bool = false

var player : Player 

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
	player = get_tree().get_first_node_in_group("Player")
	process_mode = Node.PROCESS_MODE_ALWAYS
	rand_weed = RandomNumberGenerator.new()
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
		player.ui_choose_seed.show()
		player.ui_choose_seed.visible = true
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		player.ui_choose_seed.hide()
		player.ui_choose_seed.visible = false
	#plant_seed()
	#print("planting...")

func grow_weed():
	rand_weed.randomize()
	var val = rand_weed.randi_range(0, 5)
	if val == 1 and !has_weed:
		has_weed = true
		if size == field_size.small:
			var new_weed = weed_small.instantiate()
			add_child(new_weed)
		if size == field_size.medium:
			var new_weed = weed_medium.instantiate()
			add_child(new_weed)
		if size == field_size.large:
			var new_weed = weed_large.instantiate()
			add_child(new_weed)
			
func delete_weed():
	for child in get_children(true):
		if child.is_in_group("weed"):
			child.queue_free()
		

func check_for_weed():
	if has_weed and is_occupied:
		for plant in get_children():
			if plant is Plant:
				plant.contest_points -= 1
				print(plant.name, " lost 1 point -> ", plant.contest_points)
		
	

func reset():
	set_watered(false)
	is_occupied = false
	has_harvestable_plant = false

func plant_seed(plant_type : Plant.plant_type):
	Global.lose_energy(energy_cost)
	is_occupied = true
	var new_plant = plant.instantiate()
	new_plant.type = plant_type
	add_child(new_plant)
	new_plant.global_position += Vector3(0,0.25,0)
	

#func set_plant_offset():
	#if size == field_size.small:
		#plant_offset = Vector3(0,0,0)
	#if size == field_size.medium:
		#plant_offset = Vector3(0.5,0,0.5)
	#if size == field_size.large:
		#plant_offset = Vector3(1,0,1)
		

