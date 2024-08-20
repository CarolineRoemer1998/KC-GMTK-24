extends CanvasLayer

@onready var selling_plant = $Panel/Selling_Plant

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()

var player: Player
var plant: Plant
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_market(entered_player : Player):
	
	player = entered_player
	plant = player.interaction.carrying_plant
	visible = true
	if plant != null:
		selling_plant.fill_stats(plant)

func close_market():
	visible = false

func _on_button_pressed():
	pass
