extends State
class_name PlayerIdleSwimState

signal move_topdown(direction: Vector2)

@export var water_gravity: float

@export_group("States")
@export var swim_move_state: State
@export var boat_idle_state: State

func process_physics(delta: float) -> State:
	var move_direction: Vector2 = Input.get_vector("player_fishing_move_left","player_fishing_move_right","player_fishing_swim_up","player_fishing_swim_down")
	
	if move_direction != Vector2.ZERO:
		return swim_move_state
	
	move_topdown.emit(Vector2(0, water_gravity))
	
	return null
