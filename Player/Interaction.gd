extends Node3D

var field: Field

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_just_pressed("T_Plow") && field != null:
		plow()

func plow():
	pass
