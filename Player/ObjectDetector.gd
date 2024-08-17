extends Area3D

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

var current_detected = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area3D) -> void:
	print(area.get_parent().name)
	for child in get_parent().get_parent().get_children():
		if child.name == "Interaction":
			child.field = area.get_parent()
			print("aktuelles Feld: ", child.field)
	current_detected = area
	for child in area.get_parent().get_children():
		if child.name == "Highlight":
			child.visible = true
			child.get_parent().is_chosen = true


func _on_area_exited(area: Area3D) -> void:
	current_detected = null
	for child in area.get_parent().get_children():
		if child.name == "Highlight" and child.visible == true:
			child.visible = false
			child.get_parent().is_chosen = false
