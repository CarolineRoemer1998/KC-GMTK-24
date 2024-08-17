extends Node3D

class_name Plant

enum growth_size {small, medium, large}


@export var needs_water : bool = false
@export var isInfested : bool = false
@export var start_growth_points: int = 3
@export var current_growth_points: int = 3

@export_range(1,3) var level: int = 1 
# Getter method
func get_level() -> int:
	return level

# Setter method with min and max constraints
func set_sevel(new_level: int) -> void:
	level = clamp(new_level, 1, 3)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	current_growth_points = start_growth_points


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func grow():
	current_growth_points -= 1
	print(str(current_growth_points) + " Growthpoints")
	if current_growth_points< 1:
		print("Level Up")
		current_growth_points = start_growth_points
