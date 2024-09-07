extends TextureRect

class_name SeedStorage

@onready var label: Label = $TextureRect/Label
@export var seed_type : Plant.plant_type
var amount : int

func _ready() -> void:
	match seed_type:
		Plant.plant_type.carrot:
			change_amount(Inventory.amount_carrots)
		Plant.plant_type.cauliflower:
			change_amount(Inventory.amount_cauliflowers)
		Plant.plant_type.zucchini:
			change_amount(Inventory.amount_zucchinis)
		Plant.plant_type.strawberry:
			change_amount(Inventory.amount_strawberries)
		

func change_amount(_amount : int):
	amount = _amount
	label.text = str(amount)
