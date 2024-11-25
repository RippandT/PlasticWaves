extends SceneInitializer
class_name OverworldScene

func extra_initialization() -> void:
	$BoatParty.initialize(game_info.boat_data)
	print(game_info)
