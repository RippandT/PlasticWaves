extends CharacterBody2D
class_name PlayerMovement

signal update_player_direction(direction: Vector2)

@export var speed_multiplier: float = 1

const DISTANCE_DEADZONE: float = 1
var move_to_position: Vector2 = Vector2(0, 0)
var is_moving: bool = false
var speed: Vector2 = Vector2(1, 1)

func _ready() -> void:
    speed *= speed_multiplier

func _process(delta):
    if is_moving == false:
        return
    if position.distance_to(move_to_position) <= DISTANCE_DEADZONE:
        is_moving = false
        return

    var direction: Vector2 = position.direction_to(move_to_position)

    if direction:
        velocity.x = direction.x * speed.x
        velocity.y = direction.y * speed.y
    else:
        velocity.x = move_toward(velocity.x, 0, speed.x)
        velocity.y = move_toward(velocity.y, 0, speed.y)

    move_and_slide()
    update_player_direction.emit(direction)


func move_player_to_position(next_position: Vector2):
    move_to_position = next_position
    is_moving = true
    