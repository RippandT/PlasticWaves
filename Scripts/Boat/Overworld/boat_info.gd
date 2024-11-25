extends Resource
class_name BoatData

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
