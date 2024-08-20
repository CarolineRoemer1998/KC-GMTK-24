extends Node3D

@onready var shop_ui = $Shop_Ui

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_area_entered(area):
	shop_ui.show_shop(area.get_parent().get_parent())
	Global.lose_energy(1)

func _on_area_3d_area_exited(area):
	shop_ui.close_shop()
