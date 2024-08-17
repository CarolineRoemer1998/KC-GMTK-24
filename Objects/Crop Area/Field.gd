extends StaticBody3D

class_name Field
enum field_size {small, medium, large}
@export var max_level: int = 4
@export var size: field_size
@export var plant: PackedScene

var is_chosen: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("T_Plant"):
		plant_seed()

func plant_seed():
	var new_plant = plant.instantiate()
	add_child(new_plant)

func plow():
	pass
