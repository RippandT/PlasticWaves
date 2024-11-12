extends Node
class_name PlayerInfo

signal remove_player_from_field(player_id)
signal new_player_connected(player_data)

var player_data: Array[PlayerData]


func player_connected(player_id, player_name:String):
	load_new_player.rpc(player_id, player_name)

## Load new player by player name
@rpc("any_peer", "call_local", "reliable")
func load_new_player(player_id: int, player_name: String = ""):
	var new_player_data: PlayerData = PlayerData.new()
	new_player_data.player_name = player_name
	new_player_data.player_id = player_id
	player_data.append(new_player_data)
	new_player_connected.emit(new_player_data)
	print(new_player_data.player_id)


func load_player_data(player_id: int):
	pass

# Multiplayer Functionality
func remove_player(player_id: int):
	rpc("rpc_remove_player", player_id)

@rpc("any_peer", "call_local") func rpc_remove_player(player_id: int):
	player_data.erase(player_id)
	remove_player_from_field.emit(player_id)
