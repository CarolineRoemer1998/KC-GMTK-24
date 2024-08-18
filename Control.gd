extends Control

@onready var slices: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		slices.append(child)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("T_Grow"):
		Global.current_energy -= 1
		print(Global.current_energy)
		update_slices()
		
func update_slices():
	for i in range(Global.start_energy):
		if i < Global.current_energy:
			slices[i].modulate = Color(1, 1, 1)
		else:
			slices[i].modulate = Color(0.2, 0.2, 0.2)
