extends Area2D
class_name FishingBase

@export var fisherman_player: FishermanMovement
var activated: bool = false
var player_fish_inventory

func activate_fishing(active: bool) -> void:
	return

# Fish to Player Inventory #
func add_fish_to_inventory(fish: Fish) -> void:
	var fish_dict: Dictionary = {"fish_name": fish.fish_name,"fish_weight": fish.fish_weight}
	fisherman_player.player_data.fish_captured.append(fish_dict)

func clear_fishes_from_inventory() -> void:
	fisherman_player.player_data.fish_captured.clear()

func get_fish_inventory_count() -> int:
	return fisherman_player.player_data.fish_captured.size()

func is_fish_inventory_full() -> bool:
	return get_fish_inventory_count() >= fisherman_player.player_data.max_fish_in_inventory

# Fish to Boat Inventory #
func add_fishes_to_boat() -> void:
	fisherman_player.place_fish_in_boat_inventory.emit(fisherman_player.player_data.fish_captured)
	clear_fishes_from_inventory()
