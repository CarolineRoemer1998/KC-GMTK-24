extends CanvasLayer
class_name Shop_ui

@onready var buy_small_field: TextureRect = $MarginContainer/Background/HBoxFields/Buy_small_field
@onready var buy_med_field: TextureRect = $MarginContainer/Background/HBoxFields/Buy_med_field
@onready var buy_large_field: TextureRect = $MarginContainer/Background/HBoxFields/Buy_large_field

@onready var button_carrot: TextureRect = $MarginContainer/Background/HBoxSeeds/button_carrot
@onready var button_cauliflower: TextureRect = $MarginContainer/Background/HBoxSeeds/button_cauliflower
@onready var button_zucchini: TextureRect = $MarginContainer/Background/HBoxSeeds/button_zucchini
@onready var button_strawberry: TextureRect = $MarginContainer/Background/HBoxSeeds/button_strawberry
@onready var button_close_shop: TextureRect = $MarginContainer/Background/MarginContainer/ButtonCloseShop

@export var field_placer_small: PackedScene
@export var field_placer_medium: PackedScene
@export var field_placer_large: PackedScene

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
	if Input.is_action_just_pressed("mouse_left"):
		buy_small_field.texture.region = SEED_BUTTON_RECT_PRESSED
		instantiate_field_placer("small_field", field_placer_small)

func _on_buy_med_field_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		buy_med_field.texture.region = SEED_BUTTON_RECT_PRESSED
		instantiate_field_placer("medium_field", field_placer_medium)

func _on_buy_large_field_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		buy_large_field.texture.region = SEED_BUTTON_RECT_PRESSED
		instantiate_field_placer("large_field", field_placer_large)

func instantiate_field_placer(field_name : String, field_placer_node):
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
	if Input.is_action_just_pressed("mouse_left"):
		printerr("buying carrot seeds")
		button_carrot.texture.region = SEED_BUTTON_RECT_PRESSED
		Global.check_money(price_dic["carrot"])
		if Global.is_affordable:
			Global.spend_money(price_dic["carrot"])
			Inventory.amount_carrots += 1
	if Input.is_action_just_released("mouse_left"):
		button_carrot.texture.region = SEED_BUTTON_RECT_UNPRESSED

func _on_button_cauliflower_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		printerr("buying cauliflower seeds")
		button_cauliflower.texture.region = SEED_BUTTON_RECT_PRESSED
		Global.check_money(price_dic["cauliflower"])
		if Global.is_affordable:
			Global.spend_money(price_dic["cauliflower"])
			Inventory.amount_cauliflowers += 1
	if Input.is_action_just_released("mouse_left"):
		button_cauliflower.texture.region = SEED_BUTTON_RECT_UNPRESSED


func _on_button_zucchini_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		printerr("buying zucchini seeds")
		button_zucchini.texture.region = SEED_BUTTON_RECT_PRESSED
		Global.check_money(price_dic["zucchini"])
		if Global.is_affordable:
			Global.spend_money(price_dic["zucchini"])
			Inventory.amount_zucchinis += 1
	if Input.is_action_just_released("mouse_left"):
		button_zucchini.texture.region = SEED_BUTTON_RECT_UNPRESSED


func _on_button_strawberry_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		print_rich("[color=blue]Hello")
		printerr("buying strawberry seeds")
		button_strawberry.texture.region = SEED_BUTTON_RECT_PRESSED
		Global.check_money(price_dic["strawberry"])
		if Global.is_affordable:
			Global.spend_money(price_dic["strawberry"])
			Inventory.amount_strawberries += 1
	if Input.is_action_just_released("mouse_left"):
		button_strawberry.texture.region = SEED_BUTTON_RECT_UNPRESSED



func _on_button_close_shop_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		visible = false

func modulate_hovering(node):
	node.modulate = Color(0.8,0.8,0.8,1)

func modulate_not_hovering(node):
	node.modulate = Color(1,1,1,1)

func _on_margin_container_mouse_entered() -> void:
	modulate_hovering(button_close_shop)

func _on_margin_container_mouse_exited() -> void:
	modulate_not_hovering(button_close_shop)


func _on_button_carrot_mouse_entered() -> void:
	modulate_hovering(button_carrot)
	
func _on_button_carrot_mouse_exited() -> void:
	modulate_not_hovering(button_carrot)


func _on_button_cauliflower_mouse_entered() -> void:
	modulate_hovering(button_cauliflower)

func _on_button_cauliflower_mouse_exited() -> void:
	modulate_not_hovering(button_cauliflower)


func _on_button_zucchini_mouse_entered() -> void:
	modulate_hovering(button_zucchini)

func _on_button_zucchini_mouse_exited() -> void:
	modulate_not_hovering(button_zucchini)


func _on_button_strawberry_mouse_entered() -> void:
	modulate_hovering(button_strawberry)

func _on_button_strawberry_mouse_exited() -> void:
	modulate_not_hovering(button_strawberry)




func _on_buy_small_field_mouse_entered() -> void:
	modulate_hovering(buy_small_field)


func _on_buy_small_field_mouse_exited() -> void:
	modulate_not_hovering(buy_small_field)


func _on_buy_med_field_mouse_entered() -> void:
	modulate_hovering(buy_med_field)


func _on_buy_med_field_mouse_exited() -> void:
	modulate_not_hovering(buy_med_field)


func _on_buy_large_field_mouse_entered() -> void:
	modulate_hovering(buy_large_field)


func _on_buy_large_field_mouse_exited() -> void:
	modulate_not_hovering(buy_large_field)
