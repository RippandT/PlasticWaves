extends Area2D
class_name OverworldSpot

@export_enum("Overworld", "Fishing", "Selling") var next_scene: int
var game: GameInfo

func _enter_tree():
	game = get_parent().game_info
	body_entered.connect(boat_entered)

func go_fishing():
	print(next_scene)
	game.change_scene(next_scene)

func boat_entered(boat: BoatOverworldCharacter):
	boat.go_fishing.connect(go_fishing)

func boat_exited(boat: BoatOverworldCharacter):
	boat.go_fishing.disconnect(go_fishing)
