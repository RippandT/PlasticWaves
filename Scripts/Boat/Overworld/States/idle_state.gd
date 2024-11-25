extends State
class_name BoatIdleState

@export_group("States")
@export var moving_state: State
@export var interacting_state: State

var animation_suffix: String

#var info: BoatData

func init_state() -> void:
	return
	#info = parent.game_info.boat_data

func enter() -> void:
	#if animation_suffix == "":
	#	animation_suffix = animation_name
	#animation_name = parent.boat_info.direction_array[parent.boat_info.direction] + animation_suffix
	super()

func process_physics(delta: float) -> State:
	var move_direction: Vector2 = Input.get_vector("player_overworld_move_left", "player_overworld_move_right", "player_overworld_move_up", "player_overworld_move_down")
	
	if move_direction != Vector2.ZERO:
		return moving_state
	
	return null
