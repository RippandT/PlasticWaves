extends CharacterMovement
class_name FishermanMovement

@export var swim_speed: float

var underwater: bool = false

func _ready() -> void:
	speed_x = speed
	speed_y = speed


func _process(delta) -> void:
	#print(underwater)
	pass


func swim_movement(direction: Vector2):
	if direction.x:
		velocity.x = direction.x * swim_speed
	else:
		# TODO: Make the motion a bit slippery
		velocity.x = move_toward(velocity.x, 0, swim_speed)
	
	if direction.y:
		# Commented code pulls the player downwards, but it makes the player feel heavy
		# Experimental, disabled for now
		velocity.y = (direction.y * swim_speed)# + (get_gravity().y * get_physics_process_delta_time())
	else:
		velocity.y = move_toward(velocity.y, get_gravity().y * get_physics_process_delta_time(), swim_speed)
	
	move_and_slide()
