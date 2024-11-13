extends CharacterBody2D
class_name CharacterMovement

## Default speed of the characterbody
@export var speed = 300.0
## Default jump height of the characterbody
@export var jump_height = 30.0

# In hindsight, these are supposed to be one Vector2.
# Will be changed when we refractor the codebase
## The speed of the character going horizontally
var speed_x: float = 0.0
## The speed of the character going vertically
var speed_y: float = 0.0

## Used for topdown movement (e.g. Overworld Boat)
func move_character_topdown(direction: Vector2):
	if direction:
		velocity.x = direction.x * speed_x
		velocity.y = direction.y * speed_y
	else:
		velocity.x = move_toward(velocity.x, 0, speed_x)
		velocity.y = move_toward(velocity.y, 0, speed_y)
	
	move_and_slide()

## Used for platformer style of movement; along a 2D plane
func move_character_platformer(direction: float, wants_jump: bool):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * get_physics_process_delta_time()

	# Handle jump.
	if wants_jump and is_on_floor():
		velocity.y = speed_y
		
	if direction:
		velocity.x = direction * speed_x
	else:
		velocity.x = move_toward(velocity.x, 0, speed_x)

	move_and_slide()
