extends CanvasLayer

@onready var selling_plant = $Panel/Selling_Plant
@onready var button = $Panel/Button

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
		button.text = "Sell " + str(get_plant_type(plant.type)) + " for: " + str(selling_plant.get_plant_price(plant))

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

func _on_button_pressed():
	if player.interaction.carrying_plant != null:
		Global.gain_money(selling_plant.get_plant_price(plant))
		
		player.carrying_weight = Player.Weight.none
		plant.queue_free()
		close_market()
		selling_plant.remove_plant()
