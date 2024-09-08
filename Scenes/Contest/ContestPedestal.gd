extends StaticBody3D

var player : Player
var contest_plant  : Plant
var can_submit_plant : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("save") && can_submit_plant:
		Global.set_contest_plant(contest_plant)

func _on_area_3d_area_entered(area):
	print(area.name)
	player = area.get_parent().get_parent()
	contest_plant = player.interaction.carrying_plant
	if contest_plant != null:
		can_submit_plant = true
