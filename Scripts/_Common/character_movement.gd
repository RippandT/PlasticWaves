extends CharacterBody2D
class_name CharacterMovement

## Default speed of the characterbody
@export var speed: Vector2 = Vector2(300.0, 300.0)
## Default jump height of the characterbody
@export var jump_height = 30.0

## Used for topdown movement
func move_character_topdown(direction: Vector2, delta: float):
	if direction:
		velocity.x = direction.x * speed.x * delta
		velocity.y = direction.y * speed.y * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed.x)
		velocity.y = move_toward(velocity.y, 0, speed.y)
	
	move_and_slide()

## Used for platformer style of movement; along a 2D plane
func move_character_platformer(direction: float, wants_jump: bool, delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if wants_jump and is_on_floor():
		velocity.y = speed.y * delta
		
	if direction:
		velocity.x = direction * speed.x * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed.x)

	move_and_slide()
