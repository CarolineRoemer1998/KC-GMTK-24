extends Node3D

@export var strawberry_small : PackedScene
@export var strawberry_medium : PackedScene
@export var strawberry_large : PackedScene

@export var carrot_small : PackedScene
@export var carrot_medium : PackedScene
@export var carrot_large : PackedScene

@export var zucchini_small : PackedScene
@export var zucchini_medium : PackedScene
@export var zucchini_large : PackedScene

@export var cauliflower_small : PackedScene
@export var cauliflower_medium : PackedScene
@export var cauliflower_large : PackedScene

@onready var player : Player = $Player
@onready var fruit_spawner = $FruitSpawner
@onready var spawn_timer = $SpawnTimer

var random_spawn_range 
var allow_spawning : bool = true
var fruit_array : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	player.can_move = false
	fruit_array.append_array([strawberry_small,strawberry_medium,strawberry_large, carrot_small, carrot_medium, carrot_large, cauliflower_small, cauliflower_medium, cauliflower_large, zucchini_small, zucchini_medium, zucchini_large])
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mouse_left"):
		spawn_fruits()
	
	if spawn_timer.is_stopped():
		spawn_timer.start()
	
func spawn_fruits():
	
	if allow_spawning:
		random_spawn_range = RandomNumberGenerator.new()
		var spawn_point = random_spawn_range.randf_range(-10.0, 10.0)
		fruit_array.shuffle()
		var new_fruit = fruit_array[0].instantiate()
		printerr(new_fruit.name)
		fruit_spawner.add_child(new_fruit)
		new_fruit.position = Vector3(spawn_point,0,0)
		var random = RandomNumberGenerator.new()
		random.randomize()
		var random_factor_x = random.randi_range(0, 359)
		var random_factor_y = random.randi_range(0, 359)
		new_fruit.rotation_degrees = Vector3(random_factor_x,random_factor_y,0)
		printerr(new_fruit.position)
		


func _on_spawn_timer_timeout():
	spawn_fruits()
