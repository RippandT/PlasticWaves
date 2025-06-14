extends CharacterBody2D
class_name PlayerMovement

signal update_player_direction(direction: Vector2)

@export var speed_multiplier: float = 1

const DISTANCE_DEADZONE: float = 1

var move_to_position: Vector2 = Vector2(0, 0)
var is_moving: bool = false
var speed: Vector2 = Vector2(1, 1)
var player_movement_permission: bool = true

func _ready() -> void:
    speed *= speed_multiplier

#func _unhandled_input(event: InputEvent) -> void:
#    var horizontal_movement: float = Input.get_axis("player_overworld_move_left", "player_overworld_move_right")
#    var vertical_movement: float = Input.get_axis("player_overworld_move_up", "player_overworld_move_down")
#    move_player_to_position(Vector2(horizontal_movement, vertical_movement))

func _process(delta):
    if is_moving == false or player_movement_permission == false:
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
    if player_movement_permission == false:
        return
    
    move_to_position = next_position
    is_moving = true

func set_player_movement_permission(permit: bool):
    player_movement_permission = permit

func set_player_movement_vector_speed(vector_speed: Vector2):
    speed = vector_speed

func set_player_movement_speed_multiplier(multiplier: float) -> void:
    speed_multiplier = multiplier