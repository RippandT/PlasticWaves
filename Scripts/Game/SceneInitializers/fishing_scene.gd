extends SceneInitializer
class_name FishingScene

@export var fisherman_spawn: Marker2D
@export var fisherman_object: PackedScene
@export var fisherman_spawn_node: Node2D
var player_list: Array[String]

func extra_initialization() -> void:
	player_info.remove_player_from_field.connect(remove_player)
	player_info.new_player_connected.connect(add_players)
	for player in player_info.player_data:
		add_players(player)

func remove_player(player_id) -> void:
	get_node(str(player_id)).call_deferred("queue_free")
	player_list.erase(str(player_id))

func add_players(player: PlayerData) -> void:
	var fisherman_instance: Node = fisherman_object.instantiate()
	fisherman_instance.player_data = player
	fisherman_instance.player_id = player.player_id
	fisherman_instance.name = str(player.player_id)
	fisherman_instance.position = fisherman_spawn.position
	player_list.append(str(player.player_id))
	fisherman_spawn_node.add_child(fisherman_instance)

func _unhandled_input(event):
	if event.is_action_pressed("player_general_pausemenu"):
		game_info.change_scene(0)