extends Control

var player : Player
var active_field : Field

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	active_field = null

func _on_visibility_changed() -> void:
	if visible and player != null:
		active_field = player.interaction.field
	else:
		active_field = null
	print("Test:", active_field)

func plant_seed(type : Plant.plant_type):
	if !active_field.is_occupied:
		active_field.plant_seed(type)
		print("Planting ", type," seeds...")
		visible = false
		hide()

func _on_carrot_seeds_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		plant_seed(Plant.plant_type.carrot)


func _on_strawberry_seeds_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		plant_seed(Plant.plant_type.strawberry)


func _on_zucchini_seeds_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		plant_seed(Plant.plant_type.zucchini)


func _on_cauliflower_seeds_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		plant_seed(Plant.plant_type.cauliflower)
