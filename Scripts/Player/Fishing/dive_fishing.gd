extends Area2D

## WARN: Only for the prototype
@export var counter: Label
@export var boat_counter: Label

var activated: bool = false
# This is for the purpose of the prototype
# Will be changed and placed somewhere else later
var fish_caught: int = 0:
	get:
		return fish_caught
	set(value):
		fish_caught = clampi(value, 0, max_fish)
var max_fish: int = 5
var fish_in_area: Array[Node2D]

func _ready() -> void:
	body_entered.connect(fish_spotted)
	body_exited.connect(fish_exited)

func _input(event) -> void:
	if event.is_action_pressed("player_fishing_interact") and fish_caught < max_fish and activated:
		print("plz get fish")
		get_fishes()

func activate_fishing(active: bool) -> void:
	activated = active
	if active == false:
		counter.text = "0"
		boat_counter.add_to_count(fish_caught)
	# Clear the fish count when the player submerges
	fish_caught *= int(active)
	counter.visible = active
	

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
		if fish_caught >= max_fish:
			break
		fish_caught += 1
		fish.call_deferred("queue_free")
		fish_in_area.erase(fish)
	
	counter.text = str(fish_caught)
