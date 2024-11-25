extends Node
class_name GameInitializer

@export var overworld_scene: PackedScene
@export var fishing_scene: PackedScene
@export var selling_scene: PackedScene
var current_scene: Node

@onready var game_info: GameInfo = $GameInfo

func load_scene(scene: PackedScene) -> void:
	var loaded_scene: SceneInitializer = scene.instantiate()
	if current_scene != null:
		current_scene.call_deferred("free")
	current_scene = loaded_scene
	loaded_scene.initialize_scene(game_info)
	add_child.call_deferred(loaded_scene)

func game_start(save_id: int = -1) -> void:
	game_info.load_data(save_id)
	load_scene(overworld_scene)
