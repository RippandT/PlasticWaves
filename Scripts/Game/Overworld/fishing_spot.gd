extends Area2D
class_name FishingSpot

var game: GameInfo

func _enter_tree():
	game = get_parent().game_info
	body_entered.connect(boat_entered)

func go_fishing():
	game.change_scene(1)

func boat_entered(boat: BoatOverworldCharacter):
	boat.go_fishing.connect(go_fishing)

func boat_exited(boat: BoatOverworldCharacter):
	boat.go_fishing.disconnect(go_fishing)
