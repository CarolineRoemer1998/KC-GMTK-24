extends Control

@onready var carrot_seeds: TextureRect = $carrot_seeds/seeds
@onready var strawberry_seeds: TextureRect = $strawberry_seeds/seeds
@onready var zucchini_seeds: TextureRect = $zucchini_seeds/seeds
@onready var cauliflower_seeds: TextureRect = $cauliflower_seeds/seeds


var player : Player
var active_field : Field


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	active_field = null
	
func _process(delta: float) -> void:
	if Inventory.amount_carrots == 0:
		carrot_seeds.modulate = Color(0.3, 0.3, 0.3, 1)
	else:
		carrot_seeds.modulate = Color(1,1,1,1)
	if Inventory.amount_strawberries == 0:
		strawberry_seeds.modulate = Color(0.3, 0.3, 0.3, 1)
	else:
		strawberry_seeds.modulate = Color(1,1,1,1)
	if Inventory.amount_zucchinis == 0:
		zucchini_seeds.modulate = Color(0.3, 0.3, 0.3, 1)
	else:
		zucchini_seeds.modulate = Color(1,1,1,1)
	if Inventory.amount_cauliflowers == 0:
		cauliflower_seeds.modulate = Color(0.3, 0.3, 0.3, 1)
	else:
		cauliflower_seeds.modulate = Color(1,1,1,1)


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
	if Inventory.amount_carrots > 0:
		if Input.is_action_just_pressed("mouse_left"):
			plant_seed(Plant.plant_type.carrot)


func _on_strawberry_seeds_gui_input(event: InputEvent) -> void:
	if Inventory.amount_strawberries > 0:
		if Input.is_action_just_pressed("mouse_left"):
			plant_seed(Plant.plant_type.strawberry)


func _on_zucchini_seeds_gui_input(event: InputEvent) -> void:
	if Inventory.amount_zucchinis > 0:
		if Input.is_action_just_pressed("mouse_left"):
			plant_seed(Plant.plant_type.zucchini)


func _on_cauliflower_seeds_gui_input(event: InputEvent) -> void:
	if Inventory.amount_cauliflowers > 0:
		if Input.is_action_just_pressed("mouse_left"):
			plant_seed(Plant.plant_type.cauliflower)
