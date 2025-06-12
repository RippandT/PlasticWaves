# Thank you TheShaggyDev for the State Machine tutorial, you the real one!
# https://shaggydev.com/2023/11/28/godot-4-advanced-state-machines/

extends Node
class_name StateMachine

signal state_changed(state_name: String)

@export_group("Control")
@export var entity: CharacterBody2D
#@export var entity_controller
@export var animation_player: AnimationPlayer
@export var audio_player: AudioStreamPlayer

@export_group("States")
@export var starting_state: State
var current_state: State

func _ready():
	init(entity, animation_player, audio_player)

func init(parent: CharacterBody2D, animations: AnimationPlayer = null, audio: AudioStreamPlayer = null, controller = null):
	for child in get_children():
		child.parent = parent
		child.animations = animations
		child.audio = audio
		child.controller = controller
		child.init_state()
	
	# Initialize to the default state
	change_state(starting_state)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()
	state_changed.emit(current_state.name)
	
# Pass through functions for the Player to call,
# handling state changes as needed.
func _physics_process(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func _input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func _process(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
