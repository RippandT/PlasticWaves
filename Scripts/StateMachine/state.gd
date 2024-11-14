extends Node
class_name State

@export var animation_name: String
@export var audio_to_play: AudioStream

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var parent: CharacterBody2D
var animations: AnimatedSprite2D
var audio: AudioStreamPlayer
var controller

## Code used to initialize the state for the first time
func init_state() -> void:
	pass

## Code to play when the state is activated
func enter() -> void:
	if audio != null and audio_to_play != null:
		audio.stream = audio_to_play
		audio.play()
	
	if animations != null:
		animations.play(animation_name)

## Code to play when the state is deactivated
func exit() -> void:
	if audio != null:
		audio.stop()

## _unhandled_input that acts on state changes
func process_input(event: InputEvent) -> State:
	return null

## _process that acts on state changes
func process_frame(delta: float) -> State:
	return null

## _physics_process that acts on state changes
func process_physics(delta: float) -> State:
	return null
