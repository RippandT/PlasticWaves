extends State
class_name PlayerIdleBoatState

signal move_platformer(direction: float, want_jump: bool)

@export_group("States")
@export var boat_move_state: State
@export var line_state: State
@export var swim_idle_state: State

func process_physics(delta: float) -> State:
	var move_direction: float = Input.get_axis("player_fishing_move_left","player_fishing_move_right")
	
	move_platformer.emit(0.0, false)
	
	if move_direction != 0.0:
		return boat_move_state
	
	return null
