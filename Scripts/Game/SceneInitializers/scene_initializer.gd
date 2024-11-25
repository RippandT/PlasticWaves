extends Node
class_name SceneInitializer

var game_info: GameInfo

func initialize_scene(game: GameInfo) -> void:
	game_info = game
	
	extra_initialization()

func extra_initialization() -> void:
	return
