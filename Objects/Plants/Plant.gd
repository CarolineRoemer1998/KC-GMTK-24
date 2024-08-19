extends Node3D

class_name Plant

enum plant_type {carrot, strawberry, zucchini, cauliflower}
enum growth_size {small, medium, large}

@export var needs_water : bool = true
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

# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
var contest_points : int
var watering_frequency : int
var days_since_last_watering : int

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
	current_growth_points = start_growth_points
	
	#nur zu testzwecken
	type = plant_type.carrot
	
	if type == plant_type.carrot:
		growth_stages.append(carrot_seeds)
		growth_stages.append(carrot_sprout)
		growth_stages.append(carrot_small)
		growth_stages.append(carrot_medium)
		growth_stages.append(carrot_large)
		
	# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	field = get_parent()
	days_since_last_watering = watering_frequency
	
	contest_points = 0
	set_watering_frequency()
	# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

# Getter method
func get_level() -> int:
	return level

# Setter method with min and max constraints
func set_level(new_level: int) -> void:
	level = clamp(new_level, 0, 4)
	
		
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
	
