extends CharacterBody3D

@onready var body: MeshInstance3D = $Body

const SPEED = 5.0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Only apply movement if there's an input direction
	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		# Only call look_at when the input direction is valid
		body.look_at(position + Vector3(input_dir.x, 0, input_dir.y))
		body.rotation.x = 0
	else:
		# Decelerate when no input
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
