extends Node3D

var player : Player 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	player = get_tree().get_first_node_in_group("Player")

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
		player.interaction.carrying_plant.reparent(get_tree().get_first_node_in_group("Chest"))
		player.interaction.is_throwing = true
		player.interaction.carrying_plant.animation_player.play("shrink")
	
	
		
func end_day():
	get_tree().call_group("Plant","update_to_new_day")
	start_new_day()
func start_new_day():
	Global.refill_energy()
