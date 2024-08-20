extends Control

class_name StoredPlantsUI

@onready var slot_1: TextureRect = $Slot1
@onready var slot_2: TextureRect = $Slot2
@onready var slot_3: TextureRect = $Slot3
@onready var slot_4: TextureRect = $Slot4
@onready var slot_5: TextureRect = $Slot5
@onready var slot_6: TextureRect = $Slot6
@onready var slot_7: TextureRect = $Slot7
@onready var slot_8: TextureRect = $Slot8

const CARROT = preload("res://Blender Objects/ui/plant_images/carrot.png")
const CAULIFLOWER = preload("res://Blender Objects/ui/plant_images/cauliflower.png")
const STRAWBERRY = preload("res://Blender Objects/ui/plant_images/strawberry.png")
const ZUCCHINI = preload("res://Blender Objects/ui/plant_images/zucchini.png")



@export var carrot_image : PackedScene
@export var strawberry_image : PackedScene
@export var zucchini_image : PackedScene
@export var cauliflower_image : PackedScene

var slots 

func _ready():
	slots = {
	slot_1: null,
	slot_2: null,
	slot_3: null,
	slot_4: null,
	slot_5: null,
	slot_6: null,
	slot_7: null,
	slot_8: null,
	}

func store_plant(plant : Plant) -> bool:
	var was_successful : bool = false
	for slot in slots:
		if slots[slot] == null:
			slots[slot] = plant
			plant.reparent(slot)
			was_successful = true
			set_plant_image(slot, slots[slot])
			slot.fill_stats(plant)
			break
	return was_successful

func set_plant_image(slot : TextureRect, plant : Plant):
	for i in slot.get_children():
		if i.name == "plant_image" and i is TextureRect:
			i.set_texture(CARROT)




func _on_slot_1_gui_input(event: InputEvent) -> void:
	var removed_plant = slot_1.remove_plant()
	
