extends CanvasLayer

@onready var selling_plant: Slot = $MarginContainer/Background/Selling_Plant
@onready var selling_price: Label = $MarginContainer/Background/button_sell/HBoxContainer/Price
@onready var button_sell: TextureRect = $MarginContainer/Background/button_sell

const SELLING_BUTTON_RECT_UNPRESSED := Rect2(11,38,26,19)
const SELLING_BUTTON_RECT_PRESSED := Rect2(59,38,26,19)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()

var player: Player
var plant: Plant

func show_market(entered_player : Player):
	player = entered_player
	visible = true
	if player.interaction.carrying_plant != null:
		plant = player.interaction.carrying_plant
		selling_plant.fill_stats(plant)
		selling_plant.set_plant_image(plant)
		selling_price.text = "Sell for " + str(selling_plant.get_plant_price(plant)) + " G ?"
	else:
		selling_price.text = "Nothing to sell"
		
func get_plant_type(type: Plant.plant_type):
	match type:
		Plant.plant_type.carrot:
			return "carrot"
		Plant.plant_type.cauliflower:
			return "cauliflower"
		Plant.plant_type.zucchini:
			return "zucchini"
		Plant.plant_type.strawberry:
			return "strawberry"
func close_market():
	visible = false




func _on_button_sell_mouse_entered() -> void:
	button_sell.modulate = Color(0.8,0.8,0.8,1)


func _on_button_sell_mouse_exited() -> void:
	button_sell.modulate = Color(1,1,1,1)


func _on_button_sell_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		button_sell.texture.region = SELLING_BUTTON_RECT_PRESSED
	if Input.is_action_just_released("mouse_left"):
		button_sell.texture.region = SELLING_BUTTON_RECT_UNPRESSED
		if player.interaction.carrying_plant != null:
			Global.gain_money(selling_plant.get_plant_price(plant))
			player.carrying_weight = Player.Weight.none
			plant.queue_free()
			close_market()
			selling_plant.remove_plant()
