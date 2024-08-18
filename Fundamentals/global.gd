extends Node

var energy_bar 
var game_handler
var start_energy : int 
var current_energy : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	energy_bar = get_tree().get_first_node_in_group("EnergyBar")
	game_handler = get_tree().get_first_node_in_group("GameHandler")
	process_mode = Node.PROCESS_MODE_ALWAYS
	start_energy = 8
	current_energy = start_energy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func lose_energy(energy_cost: int):
	current_energy -= energy_cost
	energy_bar.update_slices()
	print(current_energy)
	if current_energy <= 0:
		game_handler.end_day()

func refill_energy():
	if current_energy == 0:
		current_energy = 7
	else:
		current_energy = Global.start_energy 
	energy_bar.update_slices()
