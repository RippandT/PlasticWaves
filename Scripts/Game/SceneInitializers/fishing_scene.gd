extends SceneInitializer
class_name FishingScene

@export var fisherman_spawn: Marker2D
@export var fisherman_object: PackedScene
@export var fisherman_spawn_node: Node2D
@export var fisherman_camera: FishermanCamera
@export var fish_caught_list: FishCaughtList

var can_go_out: bool = true

func extra_initialization() -> void:
	add_players(game_info.player_data)

func _unhandled_input(event):
	if event.is_action_pressed("player_general_pausemenu") and can_go_out:
		game_info.change_scene(0)

# Bro, this is getting too long lmao
func add_players(player: PlayerData) -> void:
	var fisherman_instance: FishermanMovement = fisherman_object.instantiate()
	fisherman_camera.player_to_follow = fisherman_instance
	fisherman_instance.player_data = player
	fisherman_instance.position = fisherman_spawn.position
	fisherman_instance.place_fish_in_boat_inventory.connect(send_fish_to_boat)
	fisherman_instance.place_fish_in_boat_inventory.connect(fish_caught_list.display_fish)
	fisherman_instance.can_go_out.connect(set_leave_permission)
	fisherman_spawn_node.add_child(fisherman_instance)

func send_fish_to_boat(fishes: Array[Dictionary]) -> void:
	game_info.catch_inventory.append_array(fishes)

func set_leave_permission(can_leave: bool) -> void:
	can_go_out = can_leave
