extends CharacterMovement
class_name Fish

@export_group("Fish Info")
@export var fish_name: String
## In kg, limit's 999999.99; cannot go into the negatives
@export var fish_weight: float:
	get:
		return fish_weight
	set(value):
		fish_weight = clampf(value, 0, 9999999.99)

var visibility_checker: VisibleOnScreenNotifier2D
var flip_fish: bool = false

func _ready() -> void:
	visibility_checker = $VisibilityChecker
	# Stores either -1 or 1 depending on flip_fish
	var flip_int: int = 1 - (2 * int(flip_fish))
	
	visibility_checker.screen_exited.connect(swim_away)
	
	speed_x = speed * (flip_int)
	apply_scale(Vector2(flip_int, 1))

func _physics_process(delta) -> void:
	move_character_topdown(Vector2.RIGHT)

func swim_away() -> void:
	if multiplayer.is_server():
		call_deferred("queue_free")
