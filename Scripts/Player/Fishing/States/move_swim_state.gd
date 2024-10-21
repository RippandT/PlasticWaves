extends State
class_name PlayerMovingSwimState

signal swim(direction: Vector2)
signal activation(active: bool)

@export var water_gravity: float
@export var fish_grab: Area2D

@export_group("States")
@export var land_state: State

func init_state() -> void:
	swim.connect(parent.swim_movement)
	activation.connect(fish_grab.activate_fishing)

func enter() -> void:
	activation.emit(true)

func exit() -> void:
	activation.emit(false)

func process_physics(delta: float) -> State:
	var move_direction: Vector2 = Input.get_vector("player_fishing_move_left","player_fishing_move_right","player_fishing_swim_up","player_fishing_swim_down")
	
	swim.emit(move_direction)
	
	if parent.underwater == false:
		return land_state
	
	return null
