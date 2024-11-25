extends Node
class_name GameInfo

@export var game_overseer: GameInitializer
var catch_inventory: Array[Dictionary]
var active_quest: Array[Dictionary]

var player_data: PlayerData
var boat_data: BoatData

## -- FUNCTIONS -- ##

## Increments the boats health
func increment_boat_health(increment: int, multiplier: float = 1.0):
	boat_data.boat_health += increment * multiplier

## Load the boat's data from file
func load_data(save_id: int = -1):
	var loaded_player_data: PlayerData
	var loaded_boat_data: BoatData
	# Load an existing data, but if no data then load a fresh one
	if save_id == -1:
		loaded_player_data = PlayerData.new()
		loaded_boat_data = BoatData.new()
	player_data = loaded_player_data
	boat_data = loaded_boat_data

func load_player():
	# Load an existing player 
	var new_player_data: PlayerData = PlayerData.new()
	player_data = new_player_data

## Adds a catch that the player stores in the boat
func add_catch(catch: String, size: float = 10.0):
	var catch_dict: Dictionary = {catch: size}
	catch_inventory.append(catch_dict)

## Delete the catch inventory
func clear_catch_inventory():
	catch_inventory.clear()

## Changes current scene; 0 for Overworld, 1 for Fishing, 2 for Selling
func change_scene(scene_index: int):
	match scene_index:
		0:
			game_overseer.load_scene(game_overseer.overworld_scene)
		1:
			game_overseer.load_scene(game_overseer.fishing_scene)
		2:
			game_overseer.load_scene(game_overseer.selling_scene)

## Save data in binary. Mainly used for save data.
func save_data():
	ResourceSaver.save(player_data, OS.get_user_data_dir() + "/prototype_save/player.tres")
	pass
