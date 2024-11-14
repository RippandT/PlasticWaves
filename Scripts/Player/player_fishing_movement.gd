extends CharacterMovement
class_name FishermanMovement

signal place_fish_in_boat_inventory(fishes: Array[Dictionary])
signal can_go_out(can: bool)

@export var swim_speed: float
@export var player_name_label: Label
@export var oxygen_meter: OxygenMeter

var player_data: PlayerData
@export var player_id: int = 1:
	set(id):
		player_id = id
		set_multiplayer_authority(player_data.player_id)

var underwater: bool = false

func _ready() -> void:
	player_data = PlayerData.new()
	if player_data != null:
		player_name_label.text = player_data.player_name
		oxygen_meter.setup_meter(player_data.player_health_max)
	speed_x = speed
	speed_y = speed

func swim_movement(direction: Vector2) -> void:
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

func increment_player_health(value: int) -> void:
	player_data
	player_data.player_health += value
	update_player_health()

func activate_player(player_id) -> void:
	player_id

func get_player_health() -> int:
	return player_data.player_health

func update_player_health() -> void:
	oxygen_meter.update_meter(get_player_health())
