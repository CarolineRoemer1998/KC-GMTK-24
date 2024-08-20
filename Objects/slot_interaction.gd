extends TextureRect

@onready var plant_statistics: TextureRect = $PlantStatistics

var slot_plant : Plant
@onready var plant_image: TextureRect = $plant_image


func fill_stats(plant : Plant):
	slot_plant = plant
	for child in get_children():
		if child is PlantStatistics:
			child.l_selling_price.text = get_plant_price(plant)
			child.l_plant_size.text = get_plant_size(plant)
			child.l_contest_points.text = str(plant.contest_points)

func get_plant_size(plant : Plant) -> String:
	match plant.get_level():
		2:
			return "Small"
		3:
			return "Medium"
		4:	
			return "Big"
	return ""

func get_plant_price(plant : Plant) -> String:
	match plant.get_level():
		2:
			return str(plant.selling_price_small)
		3:
			return str(plant.selling_price_medium)
		4:	
			return str(plant.selling_price_large)
	return ""

func remove_plant() -> Plant:
	var removed_plant = slot_plant
	slot_plant = null
	plant_image.texture = null
	print("Removed")
	return removed_plant


func _on_mouse_entered() -> void:
	if slot_plant != null:
		plant_statistics.visible = true


func _on_mouse_exited() -> void:
	plant_statistics.visible = false
