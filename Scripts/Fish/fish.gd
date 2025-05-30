extends CharacterMovement
class_name FishEntity

@export_group("Fish Info")
@export var fish: FishInfo
@onready var sprite: Sprite2D = $FishSprite

@export_group("Fish Movement")
## Sets the direction of the fish's movement. 
## If stationary, then the fish will stay in place (mainly used for fishes that are spawned in the middle of the water)
@export_enum("LEFT:-1",	"STATIONARY:0", "RIGHT:1") var movement_direction: int = 0
## Sets the movement pattern of the fish
## Does nothing if `movement_direction` is set to `STATIONARY`
## TODO: implement movement patterns
@export var movement_pattern: int = 0

var fish_weight: float:
	get:
		return fish_weight
	set(value):
		fish_weight = clampf(value, 0, 9999999.99)
var fish_speed: float:
	get:
		return fish_speed
	set(value):
		fish_speed = clampf(value, 0, 9999.99)

var flip_fish: bool = false

func _ready() -> void:
	setup_fish()

func setup_fish(fish_info: FishInfo = fish) -> void:
	if fish_info == null:
		return

	# Lambda functions for weight and scale 
	var set_fish_weight = func(average: float, weight_range: float):
		fish_weight = Math.roundup(randf_range(average - weight_range, average + weight_range), Math.DECIMALS.THOUSANDTHS)
	var set_fish_scale = func (weight: float):
		var size = weight / fish_info.weight_average
		set_scale(Vector2(size, size))
	
	# Set properties of the fish
	sprite.texture = fish_info.texture
	set_fish_weight.call(fish_info.weight_average, fish_info.weight_range)
	set_fish_scale.call(fish_weight)

	# For debugging purposes
	self.name = fish_info.name + " " + str(fish_weight)
	
	speed.x = fish_speed * float(abs(movement_direction))

	if movement_direction == 0:
		sprite.flip_h = bool(randi_range(0, 1))
		return
	
	sprite.flip_h = bool(movement_direction)

func _physics_process(delta) -> void:
	if movement_direction == 0:
		return
		
	move_character_topdown(Vector2(movement_direction, 0), delta)

func swim_away() -> void:
	call_deferred("queue_free")
