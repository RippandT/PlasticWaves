extends Node
class_name BoatInfo

## Clockwise, starting from "up"
var direction_array: Array[String] = ["up, up_right, right, down_right, down, down_left, left, up_left"]

# Boat Location
var direction: int = 0
var location: Vector2
var map: String

# Boat Stats
var boat_max_health: int = 100

# Boat Info
var boat_health: int:
	get:
		return boat_health
	set(value):
		boat_health = clampi(value, 0, boat_max_health)
var catch_inventory: Array[Dictionary]
var active_quest: Array[Dictionary]

## -- FUNCTIONS -- ##

## Increments the boats health
func increment_boat_health(increment: int, multiplier: float = 1.0):
	boat_health += increment * multiplier

## Adds a catch that the player stores in the boat
func add_catch(catch: String, size: float = 10.0):
	var catch_dict: Dictionary = {catch: size}
	catch_inventory.append(catch_dict)

## Delete the catch inventory
func clear_catch_inventory():
	catch_inventory.clear()

## Save the boat's data in binary. Mainly used for save data.
func save_boat_data():
	pass

## Load the boat's data from file
func load_boat_data(data: Dictionary):
	pass
