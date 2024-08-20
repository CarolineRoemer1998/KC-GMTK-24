extends Control

@onready var slices: Array
@onready var money_counter: Label = $Money/TextureRect/Money_counter


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children(true):
		print(child.name)
		if child.name == "EnergyCircle":
			for energy in child.get_children():
				if energy is Sprite2D:
					slices.append(energy)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("T_Place"):
		Global.lose_energy(1)
	money_counter.text = str(Global.current_money)
		
func update_slices():
	for i in range(Global.start_energy):
		if i < Global.current_energy:
			slices[i].modulate = Color(1, 1, 1)
		else:
			slices[i].modulate = Color(0.2, 0.2, 0.2)
