extends Control

class_name ActionOverlay

var player : Player
@onready var water: TextureRect = $water
@onready var pull_weeds: TextureRect = $pull_weeds

var game_handler: GameHandler
# Called when the node enters the scene tree for the first time.
func _ready():
	game_handler = get_parent()
	player = get_tree().get_first_node_in_group("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null and player.interaction.field != null:
		if player.interaction.field.is_occupied:
			water.modulate = Color(1,1,1,1)
			if player.interaction.field.has_weed:
				pull_weeds.modulate = Color(1,1,1,1)
			else:
				pull_weeds.modulate = Color(1,1,1,0.5)
		else:
			pull_weeds.modulate = Color(1,1,1,0.5)
			water.modulate = Color(1,1,1,0.5)
	if Input.is_action_just_pressed("PlayWateringGame"):
		game_handler.start_watering_minigame()
		hide()
		set_process(false)
	elif Input.is_action_just_pressed("PlayWeedingGame"):
		game_handler.start_lawnmowing_minigame()
		hide()
		set_process(false)
