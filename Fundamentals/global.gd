extends Node

var start_energy : int 
var current_energy : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	start_energy = 10
	current_energy = start_energy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func lose_energy(energy_cost: int):
	current_energy = current_energy - energy_cost
	print(current_energy)
