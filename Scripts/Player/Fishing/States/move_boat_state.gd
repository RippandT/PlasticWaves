extends State
class_name PlayerMoveBoatState

signal move_platformer(direction: float, want_jump: bool)

@export_group("States")
@export var sea_state: State
@export var line_fish_state: State

var time_passed: float

func init_state() -> void:
	move_platformer.connect(parent.move_character_platformer)

func process_physics(delta: float) -> State:
	time_passed += delta
	if is_multiplayer_authority():
		var move_direction: float = Input.get_axis("player_fishing_move_left","player_fishing_move_right")
		move_platformer.emit(move_direction, false)
		animate_player(move_direction)
	
	oxygen(delta, 2)
	
	if parent.underwater == true:
		return sea_state
	
	return null

func process_input(event) -> State:
	if event.is_action_pressed("player_fishing_interact") and is_multiplayer_authority():
		return line_fish_state
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
