extends TextureRect

class_name SeedStorage

@onready var label: Label = $TextureRect/Label
@export var seed_type : Plant.plant_type
var amount : int

func _ready() -> void:
	change_amount(seed_type, 0)


func change_amount(seed_type : Plant.plant_type, add_amount : int):
	match seed_type:
		Plant.plant_type.carrot:
			Inventory.amount_carrots += add_amount
			amount = Inventory.amount_carrots
		Plant.plant_type.cauliflower:
			Inventory.amount_cauliflowers += add_amount
			amount = Inventory.amount_cauliflowers
		Plant.plant_type.zucchini:
			Inventory.amount_zucchinis += add_amount
			amount = Inventory.amount_zucchinis
		Plant.plant_type.strawberry:
			Inventory.amount_strawberries += add_amount
			amount = Inventory.amount_strawberries
	label.text = str(amount)
