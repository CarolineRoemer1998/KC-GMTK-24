extends Node3D
var fields_array:Array[Vector2] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is StaticBody3D:
			fields_array.append(Vector2(child.global_position.x, child.global_position.y))
			
			
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Replace with function body.
