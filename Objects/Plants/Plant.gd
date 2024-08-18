extends Node3D

class_name Plant

enum plant_type {carrot, strawberry}
enum growth_size {small, medium, large}

@export var needs_water : bool = false
@export var isInfested : bool = false

@export var field: Field

@export var start_growth_points: int = 3
@export var current_growth_points: int = 3
@export var type: plant_type

@onready var carrot_seeds = $CarrotStages/carrot_seeds
@onready var carrot_sprout = $CarrotStages/carrot_sprout
@onready var carrot_small = $CarrotStages/carrot_small
@onready var carrot_medium = $CarrotStages/carrot_medium
@onready var carrot_large = $CarrotStages/carrot_large

@export_range(0,4) var level: int = 0 


var growth_stages: Array = []
var last_stage 
var current_stage
var max_level: int
var field_size: String
# Getter method
func get_level() -> int:
	return level

# Setter method with min and max constraints
func set_level(new_level: int) -> void:
	level = clamp(new_level, 0, 4)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	set_field_size()
	set_max_level()
	current_growth_points = start_growth_points
	
	#nur zu testzwecken
	type = plant_type.carrot
	
	if type == plant_type.carrot:
		growth_stages.append(carrot_seeds)
		growth_stages.append(carrot_sprout)
		growth_stages.append(carrot_small)
		growth_stages.append(carrot_medium)
		growth_stages.append(carrot_large)
		

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
	
