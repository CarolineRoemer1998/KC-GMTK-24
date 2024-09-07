extends Control

class_name Lawnmowing_Game

@onready var lawnmower = $Outer_Circle/Lawnmower_Spinner/Lawnmover
@onready var middle_point = $MiddlePointOffset/MiddlePoint

@export var stone : PackedScene
@export var gras : PackedScene
@export var radius: int = 150
@export var stone_count: int = 3
@export var object_number: int = 10

var random_placer: Array = []
var offset: int = 20
var index = 0

func _ready():
	place_objects()
	
func place_objects():
	
	generate_objects()
	random_placer.shuffle()
	for object in random_placer:
		var point_y = sin((360/object_number) * index + offset) * radius
		var point_x = cos((360/object_number) * index + offset) * radius
		middle_point.add_child(object)
		object.position = Vector2(point_x, point_y)
		index += 1
	
func generate_objects():
	for i in range(0, object_number + 1):
		if stone_count != 0:
			var new_stone = stone.instantiate()
			stone_count -= 1
			random_placer.append(new_stone)
		else:
			var new_gras = gras.instantiate()
			lawnmower.gras_remaining.append(new_gras)
			random_placer.append(new_gras)
