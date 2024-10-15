extends CharacterMovement
class_name BoatOverworldCharacter

@onready var boat_info: BoatInfo = $Info
@onready var state_machine: StateMachine = $States

func _ready():
	speed_x = speed
	speed_y = speed
