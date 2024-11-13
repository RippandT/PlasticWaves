extends SceneInitializer
class_name OverworldScene

func extra_initialization() -> void:
	$BoatParty.initialize(boat_info)
	print(game_info)
