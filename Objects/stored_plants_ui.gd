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

var player : Player
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
	player = get_tree().get_first_node_in_group("Player")

func store_plant(plant : Plant) -> bool:
	var was_successful : bool = false
	print("storing plant...")
	for slot in slots:
		print("looking at slot ", slot,"..., its ", slots[slot])
		if slots[slot] == null:
			slots[slot] = plant
			plant.reparent(slot)
			was_successful = true
			set_plant_image(slot, slots[slot])
			slot.fill_stats(plant)
			break
	return was_successful

func set_plant_image(slot : TextureRect, plant : Plant):
	slot.set_plant_image(plant)

func remove_plant(slot : Slot):
	var removed_plant : Plant = slot.remove_plant()
	slots[slot] = null
	if removed_plant != null:
		removed_plant.reparent(player.interaction.bone_attachment)
		player.interaction.carrying_plant = removed_plant
		removed_plant.position = removed_plant.get_carrying_position()
		removed_plant.rotation_degrees = removed_plant.get_carrying_rotation()
		player.carrying_weight = player.interaction.get_weight(removed_plant.get_level())
		removed_plant.animation_player.play_backwards("shrink")


func _on_slot_1_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		remove_plant(slot_1)


func _on_slot_2_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		remove_plant(slot_2)


func _on_slot_3_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		remove_plant(slot_3)


func _on_slot_4_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		remove_plant(slot_4)


func _on_slot_5_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		remove_plant(slot_5)


func _on_slot_6_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		remove_plant(slot_6)


func _on_slot_7_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		remove_plant(slot_7)


func _on_slot_8_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		remove_plant(slot_8)
