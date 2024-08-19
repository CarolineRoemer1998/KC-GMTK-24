extends Node3D

var player : Player 
var chest : Chest

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	player = get_tree().get_first_node_in_group("Player")
	chest = get_tree().get_first_node_in_group("Chest")
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
			player.interaction.carrying_plant.reparent(chest)
			chest.add_plant(player.interaction.carrying_plant)
			player.interaction.is_throwing = true
			player.interaction.carrying_plant.animation_player.play("shrink")
			player.carrying_weight = Player.Weight.none
	if Input.is_action_just_pressed("open_chest"):
		player
	
		
func end_day():
	get_tree().call_group("Plant","update_to_new_day")
	start_new_day()
	
func start_new_day():
	Global.current_day += 1
	Global.refill_energy()
	#if Global.current_day == Global.contest_day:
		#Global.start_contest()
