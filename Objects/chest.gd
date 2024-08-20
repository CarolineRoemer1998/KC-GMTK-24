extends StaticBody3D

class_name Chest

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var plants = []
var amount_carrots : int = 0
var amount_strawberries : int = 0
var amount_zucchini : int = 0
var amount_cauliflower : int = 0

var chest_size : int = 8

func _on_detect_player_area_body_entered(player: Node3D) -> void:
	if player is Player:
		animation_player.play("Open")
		player.interaction.in_front_of_chest = true
		player.interaction.chest_position = global_position


func _on_detect_player_area_body_exited(player: Node3D) -> void:
	if player is Player:
		animation_player.play_backwards("Open")
		player.interaction.in_front_of_chest = false
	
func add_plant(plant : Plant):
	match plant.type:
		0:
			amount_carrots += 1
		1:
			amount_strawberries += 1
		2:
			amount_zucchini += 1
		3:
			amount_cauliflower += 1
	print("Carrots: ", amount_carrots, "\nStrawberries: ", amount_strawberries, "\nZucchinis: ", amount_zucchini, "\nCauliflowers: ", amount_cauliflower)		
	
