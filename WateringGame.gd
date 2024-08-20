extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_progress_bar: TextureProgressBar = $carrot/TextureProgressBar
@onready var progress_bar: ProgressBar = $carrot/ProgressBar
@onready var speechbubble: Sprite2D = $Speechbubble
@onready var drops: CPUParticles2D = $drops
@onready var timer_start_watering: Timer = $TimerStartWatering

var speed : float = 0.6
var cooldown : float = 0
var is_watering : bool = false
var waiting : bool = true
var tries : int = 2
	
func _process(delta: float) -> void:
	if tries > 1:
		if Input.is_action_just_pressed("ui_down"):
			timer_start_watering.start()
			speechbubble.visible = false
			animation_player.play("watering")
			tries -= 1
	if Input.is_action_pressed("ui_down") and tries > 0 and !waiting:
		speed = 0.6
		cooldown = 100
		texture_progress_bar.value += speed
		progress_bar.value += speed
		is_watering = true
		
	else:
		if Input.is_action_just_released("ui_down") and is_watering:
			animation_player.play_backwards("watering")
			is_watering = false
			tries -= 1
		if cooldown > 0:
			speed = speed*0.95
			texture_progress_bar.value += speed
			progress_bar.value += speed
			cooldown -= 1
		
	
func close_watering_game():
	queue_free()

func emit_drops():
	drops.emitting = true

func stop_emitting_drops():
	drops.emitting = false


func _on_timer_start_watering_timeout() -> void:
	waiting = false
