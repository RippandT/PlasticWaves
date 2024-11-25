extends Node
class_name PlayerInfo

signal remove_player_from_field(player_id)
signal new_player_connected(player_data)

var player_data: PlayerData

func load_player():
	# Load an existing player 
	var new_player_data: PlayerData = PlayerData.new()
	player_data.append(new_player_data)
	new_player_connected.emit(new_player_data)

func load_player_data(player_id: int):
	pass
