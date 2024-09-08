extends Camera3D

@onready var player: CharacterBody3D = $"../Player"
@export var camera_offset : Vector3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_offset = Vector3(0, 12, 14)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if camera_offset == Vector3(0, 12, 14):
		position = camera_offset + player.position
		
		
func toggle_camera_offset():
	if camera_offset == Vector3(0, 12, 14):
		camera_offset = Vector3(0,0,0)
	else:
		camera_offset = Vector3(0, 12, 14)
		global_position = Vector3(0,10,6.5)
		rotation_degrees = Vector3(-40,0,0)
