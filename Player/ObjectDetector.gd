extends Area3D

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
var game_handler: GameHandler

var current_detected = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_handler = get_tree().get_first_node_in_group("GameHandler")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area3D) -> void:
	if area.get_collision_layer() == 4:
		print(area.get_collision_layer())
		for child in get_parent().get_parent().get_children():
			if child.name == "Interaction":
				child.field = area.get_parent()
				print("aktuelles Feld: ", child.field)
		current_detected = area
		for child in area.get_parent().get_children():
			if child.name == "Highlight":
				child.visible = true
				child.get_parent().is_chosen = true
		game_handler.show_action_overlay()

func _on_area_exited(area: Area3D) -> void:
	current_detected = null
	for child in area.get_parent().get_children():
		if child.name == "Highlight" and child.visible == true:
			child.visible = false
			child.get_parent().is_chosen = false
	game_handler.hide_action_overlay()
