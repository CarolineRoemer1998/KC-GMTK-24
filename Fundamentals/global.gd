extends Node


var start_money: int = 3
var current_money: int 

var start_energy : int = 8
var current_energy : int

var sun : DirectionalLight3D
var sun_directions = {
	7: [-8, 98, Color(0.83,0.65,1.0)],
	8: [-24, 70, Color(1.0,0.6,0.8)],
	6: [-40, 42, Color(1.0, 0.6, 0.6)],
	5: [-56, 14, Color(1.0, 0.8, 0.7)],
	4: [-56, -14, Color(1.0, 0.65, 0.35)],
	3: [-40, -42, Color(1.0, 0.37, 0.25)],
	2: [-24, -70, Color(0.8, 0.1, 0.1)],
	1: [-8, -98, Color(0.1, 0.0, 0.9)],
	0: [-8, -98, Color(0.1, 0.0, 0.9)]
}

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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	energy_bar = get_tree().get_first_node_in_group("EnergyBar")
	game_handler = get_tree().get_first_node_in_group("GameHandler")
	player = get_tree().get_first_node_in_group("Player")
	sun = get_tree().get_first_node_in_group("Sun")
	rotate_sun()
	
	
	current_energy = start_energy
	current_money = start_money

func lose_energy(energy_cost: int):
	printerr(current_energy)
	current_energy -= energy_cost
	energy_bar.update_slices()
	if current_energy <= 0:
		game_handler.end_day()
	rotate_sun()
		

func rotate_sun():
	sun.rotation_degrees = Vector3(sun_directions[current_energy][0], sun_directions[current_energy][1], 0)
	sun.light_color = sun_directions[current_energy][2]

func refill_energy():
	if current_energy == 0:
		current_energy = 7
	else:
		current_energy = Global.start_energy 
	energy_bar.update_slices()
	rotate_sun()
	
func spend_money(amount : int):
	current_money = clamp(current_money - amount,0,9999)
	energy_bar.update_money()
	
func gain_money(amount : int):
	current_money = clamp(current_money + amount,0,9999)
	energy_bar.update_money()

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
	print("test")
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
