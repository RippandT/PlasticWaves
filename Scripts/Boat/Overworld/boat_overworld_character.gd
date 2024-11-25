extends CharacterMovement
class_name BoatOverworldCharacter

signal go_fishing
signal send_boat_location(location: Vector2)

var boat_data: BoatData
@onready var state_machine: StateMachine = $States

func initialize(boat: BoatData):
	boat_data = boat
	position = boat.location
	speed_x = speed
	speed_y = speed

func _unhandled_input(event):
	if event.is_action_pressed("player_overworld_interact"):
		boat_data.location = position
		go_fishing.emit()
