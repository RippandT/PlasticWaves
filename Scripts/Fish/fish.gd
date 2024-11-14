extends CharacterMovement
class_name Fish

@export var is_moving: bool = true
@export_group("Fish Info")
@export var fish_name: String
## In kg, limit's 999999.99; cannot go into the negatives
@export var fish_weight_average: float:
	get:
		return fish_weight_average
	set(value):
		fish_weight_average = clampf(value, 0, 9999999.99)
		set_range(fish_weight_average, fish_weight_range)
@export var fish_weight_range: float:
	get:
		return fish_weight_range
	set(value):
		fish_weight_range = clampf(Math.roundup(value), 0, 9999.99)
		set_range(fish_weight_average, fish_weight_range)
## In PHP
@export var fish_price_per_kilo: float:
	get:
		return fish_price_per_kilo
	set(value):
		fish_price_per_kilo = clampf(Math.roundup(value), 0, 99999.99)


var fish_weight_max: float
var fish_weight_min: float
var fish_weight: float:
	get:
		return fish_weight
	set(value):
		fish_weight = clampf(value, 0, 9999999.99)

var visibility_checker: VisibleOnScreenNotifier2D
var flip_fish: bool = false

func _ready() -> void:
	visibility_checker = $VisibilityChecker
	fish_weight = Math.roundup(randf_range(fish_weight_min, fish_weight_max), Math.DECIMALS.THOUSANDTHS)
	set_fish_scale(fish_weight)
	name = fish_name + " " + str(fish_weight)
	
	# Stores either -1 or 1 depending on flip_fish
	# Remember PEMDAS; Parenthesis first, then subtraction
	var flip_int: int = 1 - (2 * int(flip_fish))
	
	visibility_checker.screen_exited.connect(swim_away)
	
	speed_x = speed * (flip_int)
	apply_scale(Vector2(flip_int, 1))

func _physics_process(delta) -> void:
	if is_moving:
		move_character_topdown(Vector2.RIGHT)

func swim_away() -> void:
	if multiplayer.is_server():
		call_deferred("queue_free")

func set_range(average: float, range: float) -> void:
	fish_weight_max = average + range
	fish_weight_min = average - range

func set_fish_scale(weight: float) -> void:
	var fish_size = weight / fish_weight_average
	set_scale(Vector2(fish_size, fish_size))
