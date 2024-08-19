extends StaticBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_detect_player_area_body_entered(player: Player) -> void:
	animation_player.play("Open")
	player.interaction.in_front_of_chest = true
	player.interaction.chest_position = global_position


func _on_detect_player_area_body_exited(player: Player) -> void:
	animation_player.play_backwards("Open")
	player.interaction.in_front_of_chest = false
	
