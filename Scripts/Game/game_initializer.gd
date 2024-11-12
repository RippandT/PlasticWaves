extends Node
class_name GameInitializer

@export var overworld_scene: PackedScene
@export var fishing_scene: PackedScene
var current_scene: String

@onready var game_info: GameInfo = $GameInfo
@onready var player_info: PlayerInfo = $PlayerInfo
@onready var boat_info: BoatInfo = $BoatInfo

func load_scene_rpc(scene: PackedScene):
	load_scene.rpc(scene)

@rpc("any_peer", "reliable", "call_local")
func load_scene(scene: PackedScene) -> void:
	var loaded_scene: SceneInitializer = scene.instantiate()
	if !current_scene.is_empty():
		get_node(current_scene).free()
	current_scene = loaded_scene.name
	loaded_scene.initialize_scene(game_info, player_info, boat_info)
	add_child.call_deferred(loaded_scene)

func game_hosted() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(ProjectSettings.get_setting("plastic_waves/multiplayer/default_port"))
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(player_info.player_connected.bind("NewPlayer"))
	player_info.player_connected(multiplayer.multiplayer_peer.get_unique_id(), "TestPlayer")
	multiplayer.set_multiplayer_peer(peer)
	load_scene(overworld_scene)

func game_joined(ip_address: String) -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip_address, ProjectSettings.get_setting("plastic_waves/multiplayer/default_port"))
	multiplayer.set_multiplayer_peer(peer)
	multiplayer.multiplayer_peer = peer
