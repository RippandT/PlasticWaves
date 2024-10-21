extends Area2D

var activated: bool = false
var has_fish: bool = false

@export var fish_counter: Label
@export var fish_in_hook: Sprite2D

func _ready() -> void:
	body_entered.connect(get_fish)

func activate_fishing(active: bool) -> void:
	position.y = int(active)
	activated = active
	
	if active == false:
		fish_in_hook.hide()
		has_fish = false

## Moves the hook
func move(direction: float) -> void:
	position.y += direction
	if position.y <= 0.0 and has_fish:
		has_fish = false
		fish_counter.add_to_count(1)
		fish_in_hook.visible = false
		print("Got Fish")

## Hooks the fish if the gook is free
func get_fish(fish) -> void:
	if has_fish == false and activated:
		print(fish)
		fish.call_deferred("queue_free")
		has_fish = true
		fish_in_hook.visible = true
