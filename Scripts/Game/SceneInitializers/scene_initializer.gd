extends Node
class_name SceneInitializer

var game_info: GameInfo
var player_info: PlayerInfo
var boat_info: BoatInfo

var is_server: bool = true
var player_id: int = 1

func _ready() -> void:
	player_id = multiplayer.get_unique_id()
	is_server = multiplayer.is_server()

func initialize_scene(game: GameInfo, player: PlayerInfo, boat: BoatInfo) -> void:
	game_info = game
	player_info = player
	boat_info = boat
	
	extra_initialization()

func extra_initialization() -> void:
	return
