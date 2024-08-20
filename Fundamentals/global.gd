extends Node

var start_money: int = 3
var current_money: int 

var start_energy : int = 8
var current_energy : int

var energy_bar 
var game_handler

var current_day : int
var contest_day : int = 10
var days_until_contest: int

var is_affordable: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	energy_bar = get_tree().get_first_node_in_group("EnergyBar")
	game_handler = get_tree().get_first_node_in_group("GameHandler")
		
	current_energy = start_energy
	current_money = start_money

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
	
func spend_money(amount : int):
	current_money = clamp(current_money - amount,0,9999)
	
func gain_money(amount : int):
	current_money = clamp(current_money + amount,0,9999)

func check_money(price: int):
	if price <= current_money:
		is_affordable = true
		print("There you go!")
	else:
		is_affordable = false
		print("Sorry, not enough Money!")

func start_contest():
	get_tree().paused = true
	get_tree().change_scene_to_file("res://Scenes/Contest.tscn")
