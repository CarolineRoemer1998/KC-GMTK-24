extends CanvasLayer
class_name Shop_ui

@export var field_placer_small: PackedScene
@export var field_placer_medium: PackedScene
@export var field_placer_large: PackedScene

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_shop(entered_player : Player):
	#get_tree().paused = true
	player = entered_player
	visible = true
	#player.interaction.calculate_camera_ray()

func close_shop():
	visible = false


func _on_buy_small_field_pressed():
	visible = false
	var new_field_placer_small = field_placer_small.instantiate()
	if player != null:
		player.interaction.add_child(new_field_placer_small)
