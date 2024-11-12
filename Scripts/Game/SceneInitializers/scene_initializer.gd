extends Node
class_name SceneInitializer

@export var debug_mode: bool = false

var game_info: GameInfo
var player_info: PlayerInfo
var boat_info: BoatInfo

var is_server: bool = true

func _ready():
	is_server = multiplayer.is_server()
	if debug_mode:
		var player_debug: PlayerInfo = PlayerInfo.new()
		var boat_debug: BoatInfo = BoatInfo.new()
		player_debug.load_new_player(0, "TestPlayer")
		initialize_scene(null, player_debug, boat_debug)

func initialize_scene(game: GameInfo, player: PlayerInfo, boat: BoatInfo):
	game_info = game
	player_info = player
	boat_info = boat
	
	extra_initialization()

func extra_initialization() -> void:
	return
