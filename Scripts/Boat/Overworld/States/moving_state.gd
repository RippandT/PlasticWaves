extends State
class_name BoatMovingState

signal move_vector(direction: Vector2)

@export_group("States")
@export var idle_state: State
@export var interacting_state: State

var animation_suffix: String

#var info: BoatData

func init_state() -> void:
	return
	#info = parent.boat_info

func enter() -> void:
	#if animation_suffix == "":
	#	animation_suffix = animation_name
	#animation_name = info.direction_array[info.direction] + animation_suffix
	super()

func process_physics(delta: float) -> State:
	var move_direction: Vector2 = Input.get_vector("player_overworld_move_left",
						"player_overworld_move_right",
						"player_overworld_move_up",
						"player_overworld_move_down")
	
	if move_direction == Vector2.ZERO:
		return idle_state
	
	move_vector.emit(move_direction)
	
	return null
