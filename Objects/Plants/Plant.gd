extends Node3D

class_name Plant

enum plant_type {carrot, strawberry, zucchini, cauliflower}
enum growth_size {small, medium, large}

# Eigenschaften der Pflanze
var cost: int 
var selling_price_small: int 
var selling_price_medium: int 
var selling_price_large: int 
var watering_frequency : int  
var energy_gain : int

@export var needs_water : bool = true
@export var isInfested : bool = false

@export var field: Field

@export var start_growth_points: int = 3
@export var current_growth_points: int = 3
@export var type: plant_type

@onready var carrot_stages: Node3D = $CarrotStages
@onready var carrot_seeds: Node3D = $CarrotStages/carrot_seeds
@onready var carrot_sprout: Node3D = $CarrotStages/carrot_sprout
@onready var carrot_small: Node3D = $CarrotStages/carrot_small
@onready var carrot_medium: Node3D = $CarrotStages/carrot_medium
@onready var carrot_large: Node3D = $CarrotStages/carrot_large

@onready var strawberry_stages: Node3D = $StrawberryStages
@onready var strawberry_seeds: Node3D = $StrawberryStages/strawberry_seeds
@onready var strawberry_sprout: Node3D = $StrawberryStages/strawberry_sprout
@onready var strawberry_small: Node3D = $StrawberryStages/strawberry_small
@onready var strawberry_medium: Node3D = $StrawberryStages/strawberry_medium
@onready var strawberry_large: Node3D = $StrawberryStages/strawberry_large

@onready var cauliflower_stages: Node3D = $CauliflowerStages
@onready var cauliflower_seeds: Node3D = $CauliflowerStages/cauliflower_seeds
@onready var cauliflower_sprout: Node3D = $CauliflowerStages/cauliflower_sprout
@onready var cauliflower_small: Node3D = $CauliflowerStages/cauliflower_small
@onready var cauliflower_medium: Node3D = $CauliflowerStages/cauliflower_medium
@onready var cauliflower_large: Node3D = $CauliflowerStages/cauliflower_large

@onready var zucchini_stages: Node3D = $ZucchiniStages
@onready var zucchini_seeds: Node3D = $ZucchiniStages/zucchini_seeds
@onready var zucchini_sprout: Node3D = $ZucchiniStages/zucchini_sprout
@onready var zucchini_small: Node3D = $ZucchiniStages/zucchini_small
@onready var zucchini_medium: Node3D = $ZucchiniStages/zucchini_medium
@onready var zucchini_large: Node3D = $ZucchiniStages/zucchini_large

var plant_image : TextureRect

@export_range(0,4) var level: int = 0 

var growth_stages: Array = []
var last_stage 
var current_stage
var max_level: int
var field_size: String

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
var days_since_last_watering : int
var contest_points : int = 0

func set_watering_frequency():
	match type:
		plant_type.carrot:
			watering_frequency = 2
		plant_type.strawberry:
			watering_frequency = 2
		plant_type.cauliflower:
			watering_frequency = 3
		plant_type.zucchini:
			watering_frequency = 1
			

func update_to_new_day():
	days_since_last_watering += 1
	if watering_frequency <= days_since_last_watering:
		needs_water = true
		field.set_watered(false)
	if watering_frequency >= days_since_last_watering:
		grow()

func water():
	if needs_water:
		days_since_last_watering = 0
		contest_points += 1
		field.set_watered(true)

func _process(delta: float) -> void:
	if field.is_chosen:
		if Input.is_action_just_pressed("water"):
			# TODO: Start Minigame, return value for contest_points
			water()
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_field_size()
	set_max_level()
	field = get_parent()
	current_growth_points = start_growth_points
	
	#nur zu testzwecken
	type = plant_type.carrot
	load_meshes(type)

	days_since_last_watering = watering_frequency
	contest_points = 0
	
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
func set_properties(type: plant_type):
	match type:
		plant_type.carrot:
			selling_price_small = 1
			selling_price_medium = 2
			selling_price_large = 3
			watering_frequency = 2
			energy_gain = 1
			cost = 1
		plant_type.cauliflower:
			selling_price_small = 2
			selling_price_medium = 4
			selling_price_large = 6
			watering_frequency = 3
			energy_gain = 3
			cost = 2
		plant_type.zucchini:
			selling_price_small = 1
			selling_price_medium = 3
			selling_price_large = 12
			watering_frequency = 3
			energy_gain = 2
			cost = 2
		plant_type.strawberry:
			selling_price_small = 4
			selling_price_medium = 8
			selling_price_large = 10
			watering_frequency = 2
			energy_gain = 2
			cost = 3

func load_meshes(type:plant_type):
		match type:
			plant_type.carrot:
				carrot_stages.visible = true
				growth_stages.append(carrot_seeds)
				growth_stages.append(carrot_sprout)
				growth_stages.append(carrot_small)
				growth_stages.append(carrot_medium)
				growth_stages.append(carrot_large)
				set_properties(plant_type.carrot)
				
			plant_type.cauliflower:
				cauliflower_stages.visible = true
				growth_stages.append(cauliflower_seeds)
				growth_stages.append(cauliflower_sprout)
				growth_stages.append(cauliflower_small)
				growth_stages.append(cauliflower_medium)
				growth_stages.append(cauliflower_large)
				set_properties(plant_type.cauliflower)
				
			plant_type.zucchini:
				zucchini_stages.visible = true
				growth_stages.append(zucchini_seeds)
				growth_stages.append(zucchini_sprout)
				growth_stages.append(zucchini_small)
				growth_stages.append(zucchini_medium)
				growth_stages.append(zucchini_large)
				set_properties(plant_type.zucchini)
				
			plant_type.strawberry:
				strawberry_stages.visible = true
				growth_stages.append(strawberry_seeds)
				growth_stages.append(strawberry_sprout)
				growth_stages.append(strawberry_small)
				growth_stages.append(strawberry_medium)
				growth_stages.append(strawberry_large)
				set_properties(plant_type.strawberry)
				
# Getter method
func get_level() -> int:
	return level

# Setter method with min and max constraints
func set_level(new_level: int) -> void:
	level = clamp(new_level, 0, 4)
	if level >= 2:
		field.has_harvestable_plant = true
	
		
func grow():
	if get_level() < growth_stages.size()-1 && get_level() < max_level:
		current_growth_points -= 1
		print(str(current_growth_points) + " Growthpoints")
		if current_growth_points< 1:
			print("Level Up")
			level_up()
			current_growth_points = start_growth_points

func level_up():
	set_level(get_level()+1)
	last_stage = growth_stages[get_level()-1]
	if last_stage is Node3D:
		last_stage.visible = false
	current_stage = growth_stages[get_level()]
	if current_stage is Node3D:
		current_stage.visible = true
		
func set_field_size():
	var _field = get_parent()
	if _field is Field:
		field_size = str(_field.size)
		

func set_max_level():
	if field_size == str(field.field_size.small):
		max_level = 2 
	elif field_size == str(field.field_size.medium):
		max_level = 3 
	elif field_size == str(field.field_size.large):
		max_level = 4 
	
func get_carrying_position() -> Vector3:
	match type:
		plant_type.carrot:
			if get_level() == 2:
				return Vector3(0,1,1.1)
			if get_level() == 3:
				return Vector3(0,2.1,1.7)
			if get_level() == 4:
				return Vector3(0,3.2,2.2)
		plant_type.strawberry:
			if get_level() == 2:
				return Vector3(0,1.2,0.9)
			if get_level() == 3:
				return Vector3(0.1,1.1,1.5)
			if get_level() == 4:
				return Vector3(0,1.6,2.3)
		plant_type.cauliflower:
			if get_level() == 2:
				return Vector3(0,0.7,0.7)
			if get_level() == 3:
				return Vector3(0,0.5,1.5)
			if get_level() == 4:
				return Vector3(0,0.4,2)
		plant_type.zucchini:
			if get_level() == 2:
				return Vector3(0.4,-0.1,0.8)
			if get_level() == 3:
				return Vector3(0.1,1.1,0.8)
			if get_level() == 4:
				return Vector3(0.12,0.8,1.9)
	return Vector3(0,0,0)

func get_carrying_rotation() -> Vector3:
	match type:
		plant_type.carrot:
			if get_level() == 2:
				return Vector3(0,0,0)
			if get_level() == 3:
				return Vector3(11,1,0)
			if get_level() == 4:
				return Vector3(7,0,0)
		plant_type.strawberry:
			if get_level() == 2:
				return Vector3(-16,-1,0)
			if get_level() == 3:
				return Vector3(17.5,3.7,-5.2)
			if get_level() == 4:
				return Vector3(10,1,0)
		plant_type.cauliflower:
			if get_level() == 2:
				return Vector3(0,0,0)
			if get_level() == 3:
				return Vector3(0,0,0)
			if get_level() == 4:
				return Vector3(9,0,0)
		plant_type.zucchini:
			if get_level() == 2:
				return Vector3(2,9,-35)
			if get_level() == 3:
				return Vector3(-5.5,38,27)
			if get_level() == 4:
				return Vector3(10,80,65)
	return Vector3(0,0,0)
