extends State
class_name PlayerMovingSwimState

signal swim(direction: Vector2)
signal activation(active: bool)

@export var water_gravity: float
@export var fish_grab: Area2D

@export_group("States")
@export var land_state: State

var time_passed: float

func init_state() -> void:
	swim.connect(parent.swim_movement)
	activation.connect(fish_grab.activate_fishing)

func enter() -> void:
	activation.emit(true)
	parent.can_go_out.emit(false)

func exit() -> void:
	activation.emit(false)

func process_physics(delta: float) -> State:
	if is_multiplayer_authority():
		var move_direction: Vector2 = Input.get_vector("player_fishing_move_left",
													"player_fishing_move_right",
													"player_fishing_swim_up",
													"player_fishing_swim_down")
		animate_player(move_direction.x)
		swim.emit(move_direction)
	
	oxygen(delta, -1)
	
	if parent.underwater == false:
		return land_state
	
	return null

func oxygen(delta: float, increment: int) -> void:
	time_passed += delta
	if time_passed >= parent.player_data.oxygen_depletion_rate:
		parent.increment_player_health(increment)
		time_passed = 0

# This should be in another script, but that's future us problem
func animate_player(direction: float) -> void:
	if direction != 0:
		animations.play("moving_land")
	else:
		animations.play("idle")
	
	if direction <= 0:
		animations.flip_h = false
	if direction >= 0:
		animations.flip_h = true
