extends Area3D

var game_handler
# Called when the node enters the scene tree for the first time.
func _ready():
	game_handler = get_tree().get_first_node_in_group("GameHandler")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	print("Gute Nacht")
	game_handler.end_day()
