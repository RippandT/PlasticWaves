extends Area2D
class_name FishingBase

signal add_fish_counter(increment: int)
signal clear_fish_counter

@export var fisherman_player: FishermanMovement
var activated: bool = false

func activate_fishing(active: bool) -> void:
	return

# Fish to Player Inventory #
func add_fish_to_inventory(fish: Fish) -> void:
	var fish_dict: Dictionary = {"fish_name": fish.fish_name,"fish_weight": fish.fish_weight,"fish_price":fish.fish_price_per_kilo}
	fisherman_player.player_data.fish_captured.append(fish_dict)
	add_fish_counter.emit(1)

func clear_fishes_from_inventory() -> void:
	fisherman_player.player_data.fish_captured.clear()
	clear_fish_counter.emit()

func get_fish_inventory_count() -> int:
	return get_fish_inventory().size()

func get_fish_inventory() -> Array[Dictionary]:
	return fisherman_player.player_data.fish_captured

func is_fish_inventory_full() -> bool:
	return get_fish_inventory_count() >= fisherman_player.player_data.max_fish_in_inventory

# Fish to Boat Inventory #
func add_fishes_to_boat() -> void:
	fisherman_player.place_fish_in_boat_inventory.emit(get_fish_inventory())
	clear_fishes_from_inventory()
