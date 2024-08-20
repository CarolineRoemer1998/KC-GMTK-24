extends Sprite2D

class_name Lawnmower
@export var rotation_speed: float = 3.0
@onready var lawnmover_short = $"../Lawnmover_short"
@onready var collision_shape_2d = $Stone_Detector/CollisionShape2D
@onready var grasses = $"../../Grasses"

var gras_remaining : Array = []

var spinner
var outer_circle: Sprite2D
var hit_count: int
var game_won: bool

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	spinner = get_parent()
	
	for gras in grasses.get_children():
		gras_remaining.append(gras)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spinner.rotation += rotation_speed * delta
	
	
	if gras_remaining.size() == 0:
		if hit_count <= 2:
			game_won = true
		else:
			game_won = false
		Global.evaluate_minigame(game_won)
		stop_lawnmover()
	
func start_lawnmower():
	set_process(true)

func stop_lawnmover():
	get_parent().get_parent().get_parent().queue_free()

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
		print("Ouch! A Stone")
		hit_count += 1
	if area.name == "Gras":
		print("yuhu Gras")
		gras_remaining.erase(area.get_parent())
		area.get_parent().queue_free()
