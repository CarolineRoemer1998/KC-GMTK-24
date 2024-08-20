extends Node3D

var player : Player 
var chest : Chest
var stored_plants_ui : StoredPlantsUI
#@onready var lawnmowing_game = $Lawnmowing_Game
@export var lawnmowing_minigame: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	player = get_tree().get_first_node_in_group("Player")
	chest = get_tree().get_first_node_in_group("Chest")
	stored_plants_ui = get_tree().get_first_node_in_group("StoredPlants")
	Global.current_day = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Close Game"):
		get_tree().quit()
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("T_Grow"):
		end_day()
	if Input.is_action_just_pressed("harvest"):
		get_tree().call_group("Interaction","harvest")
		player.interaction.field.reset()
	if Input.is_action_just_pressed("store_plant"):
		if !player.carrying_weight == Player.Weight.none:
			if chest.stored_plants.store_plant(player.interaction.carrying_plant):
				chest.add_plant(player.interaction.carrying_plant)
				player.interaction.is_throwing = true
				player.interaction.carrying_plant.animation_player.play("shrink")
				player.carrying_weight = Player.Weight.none
			else:
				# TODO: Nachricht, dass Kiste voll ist
				pass
	if Input.is_action_just_pressed("open_chest"):
		stored_plants_ui.show()
	if Input.is_action_just_pressed("StartMinigame"):
		start_lawnmowing_minigame()

func start_lawnmowing_minigame():
	var new_lawnmowing_minigame = lawnmowing_minigame.instantiate()
	add_child(new_lawnmowing_minigame)
	disable_player()
		
func end_day():
	get_tree().call_group("Plant","update_to_new_day")
	start_new_day()
	
func start_new_day():
	Global.current_day += 1
	Global.refill_energy()
	#if Global.current_day == Global.contest_day:
		#Global.start_contest()
		
func enable_player():
		#get_parent().add_child(player)
	pass
func disable_player():
		#get_parent().remove_child(player)
	pass
