extends Node
class_name GameInfo

@export var game_overseer: GameInitializer
var catch_inventory: Array[Dictionary]
var active_quest: Array[Dictionary]

## Adds a catch that the player stores in the boat
func add_catch(catch: String, size: float = 10.0):
	var catch_dict: Dictionary = {catch: size}
	catch_inventory.append(catch_dict)

## Delete the catch inventory
func clear_catch_inventory():
	catch_inventory.clear()

## Changes current scene; 0 for Overworld 1 for Fishing
func change_scene(scene_index: int):
	match scene_index:
		0:
			game_overseer.load_scene_rpc(game_overseer.overworld_scene)
		1:
			game_overseer.load_scene_rpc(game_overseer.fishing_scene)
