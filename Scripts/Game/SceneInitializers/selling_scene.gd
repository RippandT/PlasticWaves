extends SceneInitializer
class_name SellingScene

@export var catch_summary_container: VBoxContainer
@export var fish_sold_label: PackedScene
@export var total_label: Label

# There's only 1 type of fish in the game currently
var fish_price: float = 120.0
var total_catch_price: float

func extra_initialization() -> void:
	for catch in game_info.catch_inventory:
		summarize_fish(catch)
	total_label.text = str(Math.roundup(total_catch_price))

func summarize_fish(catch: Dictionary) -> void:
	var label_instance: FishSoldLabel = fish_sold_label.instantiate()
	var catch_price: float = Math.roundup(fish_price * catch["fish_weight"])
	label_instance.display_fish(catch["fish_name"], catch["fish_weight"], catch_price)
	catch_summary_container.add_child(label_instance)
	total_catch_price += catch_price
