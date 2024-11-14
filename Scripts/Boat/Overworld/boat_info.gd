extends Node
class_name BoatInfo

## Clockwise, starting from "up"
var direction_array: Array[String] = ["up, up_right, right, down_right, down, down_left, left, up_left"]

# Boat Location
var direction: int = 0
var location: Vector2 = Vector2(621, 407)
var map: String

# Boat Stats
var boat_max_health: int = 100
var boat_health: int = 100:
	get:
		return boat_health
	set(value):
		boat_health = clampi(value, 0, boat_max_health)

## -- FUNCTIONS -- ##

## Increments the boats health
func increment_boat_health(increment: int, multiplier: float = 1.0):
	boat_health += increment * multiplier

## Save the boat's data in binary. Mainly used for save data.
func save_boat_data():
	pass

## Load the boat's data from file
func load_boat_data(data: Dictionary):
	pass
