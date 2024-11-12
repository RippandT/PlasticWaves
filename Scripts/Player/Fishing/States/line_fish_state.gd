extends State
class_name LineFishState

signal line_move(direction: float)
signal activation(active: bool)

@export var hook: Area2D

@export_group("States")
@export var land_state: State
@export var sea_state: State

func init_state() -> void:
	line_move.connect(hook.move)
	activation.connect(hook.activate_fishing)

func enter() -> void:
	activation.emit(true)

func process_physics(delta) -> State:
	if is_multiplayer_authority():
		var direction: float = Input.get_axis("player_fishing_hook_up", "player_fishing_hook_down")
		line_move.emit(direction)
	
	if parent.underwater == true:
		return sea_state
		
	return null

func process_input(event) -> State:
	if event.is_action_pressed("player_fishing_interact") and is_multiplayer_authority():
		return land_state
	return null

func exit() -> void:
	activation.emit(false)
