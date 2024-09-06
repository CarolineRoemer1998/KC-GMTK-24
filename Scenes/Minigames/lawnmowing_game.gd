extends Control

class_name Lawnmowing_Game

@onready var lawnmower = $Outer_Circle/Lawnmower_Spinner/Lawnmover
@onready var middle_point = $MiddlePointOffset/MiddlePoint

@export var stone : PackedScene
@export var gras : PackedScene
@export var radius: int = 150
@export var stone_count: int = 3
@export var object_number: int = 10

var random_factor
var offset: int = 15

func _ready():
	random_factor = RandomNumberGenerator.new()
	place_objects()

func place_objects():
	
	for i in range(object_number + 1):
		random_factor.randomize()
		var point_y = sin((360/object_number) * i + offset) * radius
		var point_x = cos((360/object_number) * i + offset) * radius
		printerr(point_x + point_y)
		var random_range = random_factor.randi_range(0,2)
		if random_range == 1 && stone_count != 0:
			var new_stone = stone.instantiate()
			middle_point.add_child(new_stone)
			new_stone.position = Vector2(point_x, point_y)
			printerr(new_stone.position)
			stone_count -= 1
		else:
			var new_gras = gras.instantiate()
			middle_point.add_child(new_gras)
			new_gras.position = Vector2(point_x, point_y)
			lawnmower.gras_remaining.append(new_gras)
			printerr(new_gras.position)
	
