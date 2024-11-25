extends Resource
class_name PlayerData

var player_name: String
var player_id: int

# Player Status
var player_health_max: int = 100
var player_health: int = 100:
	get:
		return player_health
	set(value):
		player_health = clampi(value, 0, player_health_max)
var oxygen_depletion_rate: float = 1.5

# Money
var player_money: float:
	set(value):
		player_money = Math.roundup(value)
	get:
		return player_money

# Fishing
var max_fish_in_inventory: int = 5
var fish_captured: Array[Dictionary]
var fish_reel_speed: float = 5.0
