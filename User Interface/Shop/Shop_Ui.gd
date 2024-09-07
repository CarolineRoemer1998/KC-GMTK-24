extends CanvasLayer
class_name Shop_ui

# Fields

@onready var buy_small_field: TextureRect = $MarginContainer/Background/HBoxFields/Buy_small_field
@onready var button_contents_small: MarginContainer = $MarginContainer/Background/HBoxFields/Buy_small_field/ButtonContentsSmall
@export var field_placer_small: PackedScene

@onready var buy_med_field: TextureRect = $MarginContainer/Background/HBoxFields/Buy_med_field
@onready var button_contents_medium: MarginContainer = $MarginContainer/Background/HBoxFields/Buy_med_field/ButtonContentsMedium
@export var field_placer_medium: PackedScene

@onready var buy_large_field: TextureRect = $MarginContainer/Background/HBoxFields/Buy_large_field
@onready var button_contents_large: MarginContainer = $MarginContainer/Background/HBoxFields/Buy_large_field/ButtonContentsLarge
@export var field_placer_large: PackedScene

# Seeds

@onready var button_carrot: TextureRect = $MarginContainer/Background/HBoxSeeds/button_carrot
@onready var texture_carrot: TextureRect = $MarginContainer/Background/HBoxSeeds/button_carrot/MarginContainer/TextureCarrot
@onready var in_stock_carrots: SeedStorage = $MarginContainer/Background/HBoxSeeds/button_carrot/InStockCarrots

@onready var button_cauliflower: TextureRect = $MarginContainer/Background/HBoxSeeds/button_cauliflower
@onready var texture_cauliflower: TextureRect = $MarginContainer/Background/HBoxSeeds/button_cauliflower/MarginContainer/TextureCauliflower
@onready var in_stock_cauliflowers: SeedStorage = $MarginContainer/Background/HBoxSeeds/button_cauliflower/InStockCauliflowers

@onready var button_zucchini: TextureRect = $MarginContainer/Background/HBoxSeeds/button_zucchini
@onready var texture_zucchini: TextureRect = $MarginContainer/Background/HBoxSeeds/button_zucchini/MarginContainer/TextureZucchini
@onready var in_stock_zucchinis: SeedStorage = $MarginContainer/Background/HBoxSeeds/button_zucchini/InStockZucchinis

@onready var button_strawberry: TextureRect = $MarginContainer/Background/HBoxSeeds/button_strawberry
@onready var texture_strawberry: TextureRect = $MarginContainer/Background/HBoxSeeds/button_strawberry/MarginContainer/TextureStrawberry
@onready var in_stock_strawberries: SeedStorage = $MarginContainer/Background/HBoxSeeds/button_strawberry/InStockStrawberries

# etc

@onready var button_close_shop: TextureRect = $MarginContainer/Background/MarginContainer/ButtonCloseShop


var player: Player

const SEED_BUTTON_RECT_UNPRESSED := Rect2(11,38,26,19)
var SEED_BUTTON_RECT_PRESSED := Rect2(59,38,26,19)

var price_dic = {
	
	"small_field": 1,
	"medium_field": 3,
	"large_field": 5,
	"carrot": 1,
	"cauliflower": 2,
	"zucchini": 2,
	"strawberry": 3
		
}

@onready var timer: Timer = $Timer
@onready var mouseclick: TextureRect = $mouseclick


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_shop(entered_player : Player):
	
	player = entered_player
	visible = true

func close_shop():
	visible = false


func _on_buy_small_field_gui_input(event: InputEvent) -> void:
	instantiate_field_placer("small_field", field_placer_small, buy_small_field, button_contents_small)

func _on_buy_med_field_gui_input(event: InputEvent) -> void:
	instantiate_field_placer("medium_field", field_placer_medium, buy_med_field, button_contents_medium)

func _on_buy_large_field_gui_input(event: InputEvent) -> void:
	instantiate_field_placer("large_field", field_placer_large, buy_large_field, button_contents_large)

func instantiate_field_placer(field_name : String, field_placer_node, button : Node, button_contents):
	if Input.is_action_just_pressed("mouse_left"):
		button.texture.region = SEED_BUTTON_RECT_PRESSED
		button_contents.position.y = 7
	if Input.is_action_just_released("mouse_left"):
		button.texture.region = SEED_BUTTON_RECT_UNPRESSED
		button_contents.position.y = 0
		timer.start()
		mouseclick.visible = true
		Global.check_money(price_dic[field_name])
		if Global.is_affordable:
			visible = false
			var new_field_place = field_placer_node.instantiate()
			if player != null:
				player.interaction.add_child(new_field_place)
			Global.spend_money(price_dic[field_name])

func _on_timer_timeout() -> void:
	mouseclick.visible = false


func _on_button_carrot_gui_input(event: InputEvent) -> void:
	buy_seed("carrot", button_carrot, Inventory.amount_carrots, texture_carrot, in_stock_carrots)

func _on_button_cauliflower_gui_input(event: InputEvent) -> void:
	buy_seed("cauliflower", button_cauliflower, Inventory.amount_cauliflowers, texture_cauliflower, in_stock_cauliflowers)

func _on_button_zucchini_gui_input(event: InputEvent) -> void:
	buy_seed("zucchini", button_zucchini, Inventory.amount_zucchinis, texture_zucchini, in_stock_zucchinis)

func _on_button_strawberry_gui_input(event: InputEvent) -> void:
	buy_seed("strawberry", button_strawberry, Inventory.amount_strawberries, texture_strawberry, in_stock_strawberries)

func buy_seed(seed_name : String, button : Node, inventory_spot : int, texture : Node, stock : SeedStorage):
	if Input.is_action_just_pressed("mouse_left"):
		button.texture.region = SEED_BUTTON_RECT_PRESSED
		texture.position.y = 37
	if Input.is_action_just_released("mouse_left"):
		button.texture.region = SEED_BUTTON_RECT_UNPRESSED
		texture.position.y = 30
		Global.check_money(price_dic[seed_name])
		if Global.is_affordable:
			print_rich("[color=green]buying ", seed_name, " seeds...")
			Global.spend_money(price_dic[seed_name])
			inventory_spot += 1
			stock.change_amount(inventory_spot)

func _on_button_close_shop_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		visible = false

func modulate_hovering(node, texture):
	node.self_modulate = Color(0.8,0.8,0.8,1)
	if texture != null:
		texture.self_modulate = Color(0.8,0.8,0.8,1)

func modulate_not_hovering(node, texture):
	node.self_modulate = Color(1,1,1,1)
	if texture != null:
		texture.self_modulate = Color(1,1,1,1)
		

func _on_margin_container_mouse_entered() -> void:
	modulate_hovering(button_close_shop, null)

func _on_margin_container_mouse_exited() -> void:
	modulate_not_hovering(button_close_shop, null)


func _on_button_carrot_mouse_entered() -> void:
	modulate_hovering(button_carrot, texture_carrot)
	
func _on_button_carrot_mouse_exited() -> void:
	modulate_not_hovering(button_carrot, texture_carrot)


func _on_button_cauliflower_mouse_entered() -> void:
	modulate_hovering(button_cauliflower, texture_cauliflower)

func _on_button_cauliflower_mouse_exited() -> void:
	modulate_not_hovering(button_cauliflower, texture_cauliflower)


func _on_button_zucchini_mouse_entered() -> void:
	modulate_hovering(button_zucchini, texture_zucchini)

func _on_button_zucchini_mouse_exited() -> void:
	modulate_not_hovering(button_zucchini, texture_zucchini)


func _on_button_strawberry_mouse_entered() -> void:
	modulate_hovering(button_strawberry, texture_strawberry)

func _on_button_strawberry_mouse_exited() -> void:
	modulate_not_hovering(button_strawberry, texture_strawberry)

func show_inventory_amount():
	pass


func _on_buy_small_field_mouse_entered() -> void:
	modulate_hovering(buy_small_field, null)


func _on_buy_small_field_mouse_exited() -> void:
	modulate_not_hovering(buy_small_field, null)


func _on_buy_med_field_mouse_entered() -> void:
	modulate_hovering(buy_med_field, null)


func _on_buy_med_field_mouse_exited() -> void:
	modulate_not_hovering(buy_med_field, null)


func _on_buy_large_field_mouse_entered() -> void:
	modulate_hovering(buy_large_field, null)


func _on_buy_large_field_mouse_exited() -> void:
	modulate_not_hovering(buy_large_field, null)
