extends Node


var start_money: int = 3
var current_money: int 

var start_energy : int = 8
var current_energy : int

var energy_bar 
var game_handler
var player: Player

var current_day : int
var contest_day : int = 10
var days_until_contest: int

var is_affordable: bool

var plant : Plant
var field : Field
enum MINIGAME_TYPE {watering, lawnmowing}

enum DAYTIME {Day, Sunset, Night}
var day_time : DAYTIME = DAYTIME.Day
var environment

func set_values():
	process_mode = Node.PROCESS_MODE_ALWAYS
	energy_bar = get_tree().get_first_node_in_group("EnergyBar")
	game_handler = get_tree().get_first_node_in_group("GameHandler")
	player = get_tree().get_first_node_in_group("Player")
	environment = get_tree().get_first_node_in_group("Environment")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_values()
	current_energy = start_energy
	current_money = start_money
	
	
func lose_energy(energy_cost: int):
	printerr(current_energy)
	current_energy -= energy_cost
	energy_bar.update_slices()
	if current_energy <= 0:
		game_handler.end_day()
	change_daytime()
		

func change_daytime():
	if current_energy > 5:
		day_time = DAYTIME.Day
	elif current_energy > 2:
		day_time = DAYTIME.Sunset
	else:
		day_time = DAYTIME.Night
	
	environment.change_daytime(day_time)

func refill_energy():
	if current_energy == 0:
		current_energy = 7
	else:
		current_energy = Global.start_energy 
	energy_bar.update_slices()
	change_daytime()
	
func spend_money(amount : int):
	current_money = clamp(current_money - amount,0,9999)
	energy_bar.update_money()
	
func gain_money(amount : int):
	current_money = clamp(current_money + amount,0,9999)
	energy_bar.update_money()

func check_money(price: int):
	if price <= current_money:
		is_affordable = true
	else:
		is_affordable = false
		print("Sorry, not enough Money!")

func start_contest():
	get_tree().paused = true
	get_tree().change_scene_to_file("res://Scenes/Contest.tscn")
	get_tree().paused = false

func evaluate_minigame(game_won: bool, game_type : MINIGAME_TYPE):
	player.can_move = true
	plant = player.interaction.get_plant()
	if player.interaction.field != null:
		field = player.interaction.field
	if game_type == MINIGAME_TYPE.watering:
		plant.water()
	elif game_type == MINIGAME_TYPE.lawnmowing:
		
		field.delete_weed()
	if game_won:
		if plant != null:
			plant.contest_points += 3
		print("yuhu!")
	else:
		if plant != null:
			plant.contest_points += 1
		print("buh!")

