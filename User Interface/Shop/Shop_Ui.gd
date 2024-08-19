extends CanvasLayer
class_name Shop_ui

@export var field_placer_small: PackedScene
@export var field_placer_medium: PackedScene
@export var field_placer_large: PackedScene

var player: Player

var price_dic = {
	
	"small_field": 1,
	"medium_field": 3,
	"large_field": 5,
	"carrot": 1,
	"cauliflower": 2,
	"zucchini": 2,
	"strawberry": 3
		
}



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




func _on_buy_small_field_pressed():
	Global.check_money(price_dic["small_field"])
	if Global.is_affordable:
		visible = false
		var new_field_placer_small = field_placer_small.instantiate()
		if player != null:
			player.interaction.add_child(new_field_placer_small)
		Global.spend_money(price_dic["small_field"])
	
func _on_buy_med_field_pressed():
	Global.check_money(price_dic["medium_field"])
	if Global.is_affordable:
		visible = false
		var new_field_placer_medium = field_placer_medium.instantiate()
		if player != null:
			player.interaction.add_child(new_field_placer_medium)
		Global.spend_money(price_dic["medium_field"])

func _on_buy_large_field_pressed():
	Global.check_money(price_dic["large_field"])
	if Global.is_affordable:
		visible = false
		var new_field_placer_large = field_placer_large.instantiate()
		if player != null:
			player.interaction.add_child(new_field_placer_large)
		Global.spend_money(price_dic["large_field"])

func _on_buy_carrot_pressed():
	Global.check_money(price_dic["carrot"])
	if Global.is_affordable:
		Global.spend_money(price_dic["carrot"])

func _on_buy_cauliflower_pressed():
	Global.check_money(price_dic["cauliflower"])
	if Global.is_affordable:
		Global.spend_money(price_dic["cauliflower"])

func _on_buy_zucchini_pressed():
	Global.check_money(price_dic["zucchini"])
	if Global.is_affordable:
		Global.spend_money(price_dic["zucchini"])

func _on_buy_strawberry_pressed():
	Global.check_money(price_dic["strawberry"])
	if Global.is_affordable:
		Global.spend_money(price_dic["strawberry"])
