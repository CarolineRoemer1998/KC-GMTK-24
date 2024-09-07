extends Sprite2D

class_name Lawnmower

@export var rotation_speed: float = 2.5

@onready var lawnmowing_game = $"../../.."
@onready var lawnmover_short = $"../Lawnmover_short"
@onready var collision_shape_2d = $Stone_Detector/CollisionShape2D
@onready var timer = $"../../../Timer"

var player : Player
var game_handler : GameHandler

var gras_remaining : Array = []

var spinner
var outer_circle: Sprite2D
var hit_count: int
var game_won: bool
var ouch_particle: CPUParticles2D
var is_stopped: bool

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	player = get_tree().get_first_node_in_group("Player")
	spinner = get_parent()
	game_handler = get_tree().get_first_node_in_group("GameHandler")
	
	game_handler.hide_action_overlay()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if gras_remaining.size() == 0:
		game_won = true
		Global.evaluate_minigame(game_won, Global.MINIGAME_TYPE.lawnmowing)
		stop_lawnmover()
	elif hit_count == 2:
		game_won = false
		Global.evaluate_minigame(game_won, Global.MINIGAME_TYPE.lawnmowing)
		stop_lawnmover()
	
	if !is_stopped:
		spinner.rotation += rotation_speed * delta
	
func start_lawnmower():
	set_process(true)

func stop_lawnmover():
	is_stopped = true
	if timer.is_stopped():
		timer.start(0.75)
	
	

func _input(event):
	if event.is_action_pressed("T_Lawnmower"):
		visible = false
		lawnmover_short.visible = true
		collision_shape_2d.disabled = true
	elif event.is_action_released("T_Lawnmower"):
		visible = true
		lawnmover_short.visible = false
		collision_shape_2d.disabled = false
	#elif event.is_action_released("T_Grow"):
		#var gamehandler = get_parent().get_parent().get_parent().get_parent()
		#gamehandler.enable_player()
		
func _on_stone_detector_area_entered(area):
	if area.name == "Stone":
		hit_stone(area)
	if area.name == "Gras":
		print("yuhu Gras")
		gras_remaining.erase(area.get_parent())
		area.get_parent().queue_free()

func hit_stone(stone_area: Area2D):
	for child in stone_area.get_parent().get_children():
		if child is CPUParticles2D:
			ouch_particle = child
			ouch_particle.set_emitting(true)
	print("Ouch! A Stone")
	hit_count += 1
	

func _on_timer_timeout():
	lawnmowing_game.queue_free()
	game_handler.show_action_overlay()
