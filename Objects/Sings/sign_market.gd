extends Node3D

@onready var market_ui = $Market_ui

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_area_entered(area):
	market_ui.show_market(area.get_parent().get_parent())


func _on_area_3d_area_exited(area):
	market_ui.close_market()
