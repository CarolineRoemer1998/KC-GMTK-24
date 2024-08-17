extends Node3D

class_name Plant

enum plant_type {carrot, strawberry}
enum growth_size {small, medium, large}

@export var needs_water : bool = false
@export var isInfested : bool = false

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

# Getter method
func get_level() -> int:
	return level

# Setter method with min and max constraints
func set_sevel(new_level: int) -> void:
	level = clamp(new_level, 0, 4)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	
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
	current_growth_points -= 1
	print(str(current_growth_points) + " Growthpoints")
	if current_growth_points< 1:
		print("Level Up")
		level_up()
		current_growth_points = start_growth_points

func level_up():
	level += 1
	if get_level() < growth_stages.size():
		last_stage = growth_stages[level-1]
		if last_stage is Node3D:
			last_stage.visible = false
		current_stage = growth_stages[level]
		if current_stage is Node3D:
			current_stage.visible = true
