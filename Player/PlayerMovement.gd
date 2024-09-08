extends CharacterBody3D
class_name Player

enum Weight {none, light, medium, heavy}

@onready var ui_choose_seed: Control = $ChooseSeed

@onready var body: MeshInstance3D = $Body
@onready var collision_shape_3d = $CollisionShape3D
@onready var object_detector = $Body/ObjectDetector
@onready var interaction = $Interaction
@onready var animation_player: AnimationPlayer = $Body/AnimationPlayer

var SPEED = 4.5

var can_move: bool = true
var carrying_weight : Weight = Weight.none


func _physics_process(delta: float) -> void:
	handle_animations()
	if can_move:
		
		if Input.is_action_pressed("run"):
			SPEED = 10
		if Input.is_action_just_released("run"):
			match carrying_weight:
				Weight.none:
					SPEED = 4.5
				Weight.light:
					SPEED = 4.5
				Weight.medium:
					SPEED = 4.0
				Weight.heavy:
					SPEED = 1.0
		# Get the input direction and handle the movement/deceleration.
		var input_dir := Input.get_vector("left", "right", "up", "down")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

		# Only apply movement if there's an input direction
		if direction != Vector3.ZERO:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED

			# Only call look_at when the input direction is valid
			body.look_at(position + Vector3(-input_dir.x, 0, -input_dir.y))
			body.rotation.x = 0
		else:
			# Decelerate when no input
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()

func handle_animations():
	if !can_move or Input.get_vector("left", "right", "up", "down") == Vector2(0.0,0.0):
		match carrying_weight:
			Weight.none:
				animation_player.play("idle")
			Weight.light:
				animation_player.play("idle_holding_s")
			Weight.medium:
				animation_player.play("idle_holding_m")
			Weight.heavy:
				animation_player.play("idle_holding_l")
	elif Input.get_vector("left", "right", "up", "down") != Vector2(0.0,0.0):
		match carrying_weight:
			Weight.none:
				animation_player.play("walk")
			Weight.light:
				animation_player.play("walk_holding_s")
			Weight.medium:
				animation_player.play("walk_holding_m")
			Weight.heavy:
				animation_player.play("walk_holding_l")


