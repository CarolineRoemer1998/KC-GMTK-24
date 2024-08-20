extends TextureRect

class_name Slot

@onready var plant_statistics: TextureRect = $PlantStatistics

var slot_plant : Plant
@onready var plant_image: TextureRect = $plant_image

const CARROT = preload("res://Blender Objects/ui/plant_images/carrot.png")
const CAULIFLOWER = preload("res://Blender Objects/ui/plant_images/cauliflower.png")
const STRAWBERRY = preload("res://Blender Objects/ui/plant_images/strawberry.png")
const ZUCCHINI = preload("res://Blender Objects/ui/plant_images/zucchini.png")

func fill_stats(plant : Plant):
	slot_plant = plant
	for child in get_children():
		if child is PlantStatistics:
			child.l_selling_price.text = str(get_plant_price(plant))
			child.l_plant_size.text = str(get_plant_size(plant))
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

func get_plant_price(plant : Plant) -> int:
	match plant.get_level():
		2:
			return plant.selling_price_small
		3:
			return plant.selling_price_medium
		4:	
			return plant.selling_price_large
	return 0

func remove_plant() -> Plant:
	var removed_plant = slot_plant
	slot_plant = null
	plant_image.texture = null
	print("Removed")
	return removed_plant

func set_plant_image(plant : Plant):
	for i in get_children():
		if i.name == "plant_image" and i is TextureRect:
			if plant.type == Plant.plant_type.carrot:
				i.set_texture(CARROT)
			if plant.type == Plant.plant_type.strawberry:
				i.set_texture(STRAWBERRY)
			if plant.type == Plant.plant_type.zucchini:
				i.set_texture(ZUCCHINI)
			if plant.type == Plant.plant_type.cauliflower:
				i.set_texture(CAULIFLOWER)

func _on_mouse_entered() -> void:
	if slot_plant != null:
		plant_statistics.visible = true


func _on_mouse_exited() -> void:
	plant_statistics.visible = false
