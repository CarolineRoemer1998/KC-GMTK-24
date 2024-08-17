extends RayCast3D

var current_collider : Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_colliding():
		current_collider = get_collider()
		print(current_collider.get_class())
		for child in current_collider.get_parent().get_parent().get_children():
			if child.to_string() == "Highlight":
				child.visible = true
				print("test")

