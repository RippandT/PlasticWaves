extends State
class_name PlayerMoveBoatState

signal move_platformer(direction: float, want_jump: bool)

@export_group("States")
@export var sea_state: State
@export var line_fish_state: State

func init_state() -> void:
	move_platformer.connect(parent.move_character_platformer)

func process_physics(delta: float) -> State:
	var move_direction: float = Input.get_axis("player_fishing_move_left","player_fishing_move_right")
	
	move_platformer.emit(move_direction, false)
	
	if parent.underwater == true:
		return sea_state
	
	return null

func process_input(event) -> State:
	if event.is_action_pressed("player_fishing_interact"):
		return line_fish_state
	return null
