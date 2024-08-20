extends Control

var game_handler: GameHandler
# Called when the node enters the scene tree for the first time.
func _ready():
	game_handler = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_water_gui_input(event):
	if Input.is_action_just_pressed("mouse_left"):
		game_handler.start_watering_minigame()
		
func _on_pull_weeds_gui_input(event):
	if Input.is_action_just_pressed("mouse_left"):
		game_handler.start_lawnmowing_minigame()
