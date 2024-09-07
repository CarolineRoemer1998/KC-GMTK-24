extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_progress_bar: TextureProgressBar = $carrot/TextureProgressBar
@onready var progress_bar: ProgressBar = $carrot/ProgressBar
@onready var speechbubble: Sprite2D = $Speechbubble
@onready var drops: CPUParticles2D = $drops
@onready var timer_start_watering: Timer = $TimerStartWatering
@onready var end_game: Timer = $EndGame
@onready var goal: TextureRect = $carrot/ProgressBar/goal

var game_handler : GameHandler

var speed : float = 0.6
var cooldown : float = 0
var is_watering : bool = false
var waiting : bool = true
var tries : int = 2
var rnd 
var val
var won_game : bool 
	
func _ready():
	game_handler = get_tree().get_first_node_in_group("GameHandler")
	game_handler.hide_action_overlay()
	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	val = rnd.randi_range(0, 50)
	goal.position.y = val
	
	
func _process(delta: float) -> void:
	if tries > 1:
		if Input.is_action_just_pressed("mouse_left"):
			timer_start_watering.start()
			speechbubble.visible = false
			animation_player.play("watering")
			tries -= 1
	if Input.is_action_pressed("mouse_left") and tries > 0 and !waiting:
		speed = 0.6
		cooldown = 100
		texture_progress_bar.value += speed
		progress_bar.value += speed
		is_watering = true
		
	else:
		if Input.is_action_just_released("mouse_left") and is_watering:
			animation_player.play_backwards("watering")
			is_watering = false
			tries -= 1
			end_game.start()
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


func _on_end_game_timeout() -> void:
	var result = ((140-val)/1.4)
	if result-20 < texture_progress_bar.value and result+20 > texture_progress_bar.value:
		won_game = true
	else:
		won_game = false

	Global.evaluate_minigame(won_game, Global.MINIGAME_TYPE.watering)
	game_handler.show_action_overlay()
	close_watering_game()
