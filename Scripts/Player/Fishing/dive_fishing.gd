extends FishingBase
class_name DiveFishing

# This is for the purpose of the prototype
# Will be changed and placed somewhere else later
var fish_in_area: Array[Node2D]

func _ready() -> void:
	body_entered.connect(fish_spotted)
	body_exited.connect(fish_exited)

func _input(event) -> void:
	if event.is_action_pressed("player_fishing_interact") and activated:
		get_fishes()

func activate_fishing(active: bool) -> void:
	activated = active
	if active == false:
		pass
	# Clear the fish count when the player submerges
	clear_fishes_from_inventory()
	

## Adds fish to the list of fishes when the fish is within the catching area
func fish_spotted(fish) -> void:
	print("Fish entered")
	fish_in_area.append(fish)

## Removes fish from the list of fishes when the fish swims outside the area
func fish_exited(fish) -> void:
	print("Fish exited")
	fish_in_area.erase(fish)

## Grab the fishes in the list to the count until the count reaches its maximum
## Prioritizes fishes that entered the area first
func get_fishes() -> void:
	for fish in fish_in_area:
		if is_fish_inventory_full():
			break
		add_fish_to_inventory(fish)
		fish.call_deferred("queue_free")
		fish_in_area.erase(fish)
