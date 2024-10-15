extends State
class_name PlayerMovingSwimState

signal move_platformer(direction: float, want_jump: bool)
signal swim(direction: Vector2)

@export var water_gravity: float

@export_group("States")
@export var land_state: State

func init_state() -> void:
	move_platformer.connect(parent.move_character_platformer)
	swim.connect(parent.swim_movement)

func process_physics(delta: float) -> State:
	var move_direction: Vector2 = Input.get_vector("player_fishing_move_left","player_fishing_move_right","player_fishing_swim_up","player_fishing_swim_down")
	
	#move_platformer.emit(move_direction.x, false)
	swim.emit(move_direction)
	
	if parent.underwater == false:
		return land_state
	
	return null
