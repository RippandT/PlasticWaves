extends Resource
class_name FishInfo

## The name of the fish
@export var name: String
## The texture of the fish
@export var texture: CompressedTexture2D

@export_group("Fish Weight")
## The midpoint/average weight of the fish
## In kg, limit's 999999.99; cannot go into the negatives
@export var weight_average: float:
	get:
		return weight_average
	set(value):
		weight_average = clampf(value, 0, 9999999.99)
## The weight offset of the fish
@export var weight_range: float:
	get:
		return weight_range
	set(value):
		weight_range = clampf(Math.roundup(value), 0, 9999.99)
## The price of the fish per kilo in PHP
@export var price_per_kilo: float:
	get:
		return price_per_kilo
	set(value):
		price_per_kilo = clampf(Math.roundup(value), 0, 99999.99)

@export_group("Fish Movement")
@export var speed_average: float:
	get:
		return speed_average
	set(value):
		speed_average = clampf(value, 0, 9999.99)
@export var speed_range: float:
	get:
		return speed_range
	set(value):
		speed_range = clampf(Math.roundup(value), 0, 99.99)
