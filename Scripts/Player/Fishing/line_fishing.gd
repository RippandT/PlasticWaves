extends FishingBase
class_name LineFishing

@export var fish_counter: Label
@export var fish_in_hook: Sprite2D

func _ready() -> void:
	body_entered.connect(get_fish)

func activate_fishing(active: bool) -> void:
	position.y = int(active)
	activated = active
	visible = active
	
	if active == false:
		fish_in_hook.hide()
		clear_fishes_from_inventory()

## Moves the hook
func move(direction: float) -> void:
	position.y = clampf(position.y + direction, 0.0, 140.0)
	# Check if the player is at the boat
	# Right now, it only checks if the player's above sea level
	if position.y <= 0.0 and get_fish_inventory_count() > 0:
		add_fishes_to_boat()
		fish_in_hook.visible = false

## Hooks the fish if the gook is free
func get_fish(fish: Node2D) -> void:
	if get_fish_inventory_count() == 0 and activated:
		add_fish_to_inventory(fish)
		fish.call_deferred("queue_free")
		fish_in_hook.visible = true
