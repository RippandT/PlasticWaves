extends Resource
class_name PlayerData

var player_inventory: Array[ItemObject]
var player_equipment
var player_quest: Array[QuestItem]

var player_location: LocationData
var player_position: Vector2
var player_location_bundle: LocationBundle
var player_progress: Array[LocationBundle]
