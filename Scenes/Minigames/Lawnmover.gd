extends Sprite2D

class_name Lawnmower
@export var rotation_speed: float = 3.0
@onready var lawnmover_short = $"../Lawnmover_short"
@onready var collision_shape_2d = $Stone_Detector/CollisionShape2D

var spinner
var outer_circle: Sprite2D

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	spinner = get_parent()
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spinner.rotation += rotation_speed * delta
	
func start_lawnmower():
	set_process(true)
	

func _input(event):
	if event.is_action_pressed("T_Lawnmower"):
		visible = false
		lawnmover_short.visible = true
		collision_shape_2d.disabled = true
	elif event.is_action_released("T_Lawnmower"):
		visible = true
		lawnmover_short.visible = false
		collision_shape_2d.disabled = false
	elif event.is_action_released("T_Grow"):
		var gamehandler = get_parent().get_parent().get_parent().get_parent()
		gamehandler.enable_player()
		
func _on_stone_detector_area_entered(area):
	if area.name == "Stone":
		print("Ouch! A Stone")
	if area.name == "Gras":
		print("yuhu Gras")
		area.get_parent().queue_free()
