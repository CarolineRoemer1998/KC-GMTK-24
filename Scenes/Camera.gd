extends Camera3D

@onready var player: CharacterBody3D = $"../Player"
@export var camera_offset : Vector3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_offset = Vector3(0, 12, 14)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	position = camera_offset + player.position

